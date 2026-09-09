
import argparse
import joblib
import json
from pathlib import Path
import yaml

ROOT = Path(__file__).resolve().parents[1]
with open(ROOT / "config.yaml") as f:
    CONFIG = yaml.safe_load(f)

MODELS_DIR = ROOT / CONFIG["paths"]["models"]


def save_model(model, scaler, feature_names: list, path: str):
  
    artifacts = {
        "model": model,
        "scaler": scaler,
        "feature_names": feature_names,
    }
    joblib.dump(artifacts, path)
    print(f"Model artifacts saved to: {path}")


def inspect_model(path: Path):
  
    if not path.exists():
        print(f"ERROR: File not found: {path}")
        return
    artifacts = joblib.load(path)
    print(f"\nModel Artifact: {path.name}")
    print(f"   Keys: {list(artifacts.keys())}")
    model = artifacts.get("model")
    if model is not None:
        print(f"   Model type: {type(model).__name__}")
        print(f"   Best iteration: {getattr(model, 'best_iteration', 'N/A')}")
        print(f"   n_features: {model.n_features_in_}")
    feature_names = artifacts.get("feature_names", [])
    print(f"   Features ({len(feature_names)}): {feature_names}")
    val_auc = artifacts.get("val_auc")
    val_acc = artifacts.get("val_accuracy")
    if val_auc:
        print(f"   Validation AUC: {val_auc:.4f}")
    if val_acc:
        print(f"   Validation Accuracy: {val_acc:.4f}")


def export_onnx(path: Path):

    try:
        from skl2onnx import convert_sklearn, update_registered_converter
        from skl2onnx.common.data_types import FloatTensorType
        from skl2onnx.common.shape_calculator import calculate_linear_classifier_output_shapes
        from onnxmltools.convert.xgboost.operator_converters.XGBoost import convert_xgboost
        from sklearn.pipeline import Pipeline
        from xgboost import XGBClassifier
    except ImportError as e:
        print(f"ERROR: missing dependency ({e}).")
        print("Install with: pip install skl2onnx onnxmltools onnxruntime")
        return

    artifacts = joblib.load(path)
    model = artifacts["model"]
    scaler = artifacts["scaler"]
    feature_names = artifacts["feature_names"]

    update_registered_converter(
        XGBClassifier, "XGBoostXGBClassifier",
        calculate_linear_classifier_output_shapes,
        convert_xgboost,
        options={"nocl": [True, False], "zipmap": [True, False, "columns"]},
    )

    pipeline = Pipeline([("scaler", scaler), ("model", model)])
    n_features = len(feature_names)
    initial_type = [("float_input", FloatTensorType([None, n_features]))]
    onnx_model = convert_sklearn(
        pipeline,
        initial_types=initial_type,
        target_opset={"": 15, "ai.onnx.ml": 3},
        options={id(model): {"zipmap": False}},
    )
    onnx_path = path.with_suffix(".onnx")
    with open(onnx_path, "wb") as f:
        f.write(onnx_model.SerializeToString())
    print(f"ONNX model exported: {onnx_path}")
    print("Reminder: this does not run the PKL-vs-ONNX smoke test that "
          "convert_to_tflite.py does -- verify outputs match before deploying.")


def main():
    parser = argparse.ArgumentParser(description="Inspect or export heart sclerosis model")
    parser.add_argument("--model", default="models/cardiosclerosis_model_v1.pkl")
    parser.add_argument("--inspect", action="store_true")
    parser.add_argument("--export-onnx", action="store_true")
    args = parser.parse_args()

    model_path = ROOT / args.model
    if args.inspect:
        inspect_model(model_path)
    if args.export_onnx:
        export_onnx(model_path)
    if not args.inspect and not args.export_onnx:
        inspect_model(model_path)


if __name__ == "__main__":
    main()

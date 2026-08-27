import sys, os
sys.path.insert(0, os.path.dirname(__file__))
os.environ.setdefault('FLASK_SECRET_KEY', 'render-only-not-real')
os.environ.setdefault('JWT_SECRET_KEY', 'render-only-not-real')
try:
    import app as flaskapp
    application = flaskapp.app
except Exception as e:
    print("IMPORT_ERROR", repr(e))
    sys.exit(1)

application.testing = True
client = application.test_client()
out_dir = os.path.join(os.path.dirname(__file__), '_report_render')
os.makedirs(out_dir, exist_ok=True)

pages = {
    'index.html': '/',
    'instructions.html': '/instructions',
    'join.html': '/join',
    'faq.html': '/faq',
    'contact.html': '/contact',
    'researcher_login.html': '/researcher/login',
}
for fname, route in pages.items():
    try:
        resp = client.get(route)
        with open(os.path.join(out_dir, fname), 'wb') as f:
            f.write(resp.data)
        print(route, resp.status_code, len(resp.data))
    except Exception as e:
        print(route, "ERROR", repr(e))

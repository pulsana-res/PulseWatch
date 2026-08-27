import os, base64, mimetypes, re
import jinja2

BASE = os.path.dirname(__file__)
TPL_DIR = os.path.join(BASE, 'templates')
STATIC_DIR = os.path.join(BASE, 'static')
OUT_DIR = os.path.join(BASE, '_report_render')
os.makedirs(OUT_DIR, exist_ok=True)

env = jinja2.Environment(loader=jinja2.FileSystemLoader(TPL_DIR))

ROUTES = {
    'home': '#', 'instructions_page': '#', 'faq_page': '#', 'contact_page': '#',
    'join_page': '#', 'researcher_login': '#', 'researcher_dashboard': '#',
    'download': '#', 'download_apk': '#',
}

def url_for(endpoint, **kwargs):
    if endpoint == 'static':
        fn = kwargs.get('filename', '')
        path = os.path.join(STATIC_DIR, fn)
        if os.path.exists(path):
            mime = mimetypes.guess_type(path)[0] or 'application/octet-stream'
            with open(path, 'rb') as f:
                data = base64.b64encode(f.read()).decode('ascii')
            return f'data:{mime};base64,{data}'
        return fn
    return ROUTES.get(endpoint, '#')

env.globals['url_for'] = url_for
env.globals['session'] = {}

pages = {
    'index.html': {'active_nav': 'home'},
    'instructions.html': {'active_nav': 'instructions'},
    'join.html': {'active_nav': 'join'},
    'faq.html': {'active_nav': 'faq'},
    'contact.html': {'active_nav': 'contact'},
    'researcher_login.html': {},
}

for fname, ctx in pages.items():
    try:
        tpl = env.get_template(fname)
        html = tpl.render(**ctx)
        outpath = os.path.join(OUT_DIR, fname)
        with open(outpath, 'w', encoding='utf-8') as f:
            f.write(html)
        print('OK', fname, len(html))
    except Exception as e:
        print('FAIL', fname, repr(e))

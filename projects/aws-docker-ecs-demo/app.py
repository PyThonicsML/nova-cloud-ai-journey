from http.server import SimpleHTTPRequestHandler, HTTPServer

PORT = 8080
Handler = SimpleHTTPRequestHandler
httpd = HTTPServer(("0.0.0.0", PORT), Handler)
httpd.serve_forever()



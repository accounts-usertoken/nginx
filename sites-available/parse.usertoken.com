
server {

	root /home/www/parse.usertoken.com;
	index index.html index.htm;

	server_name parse.usertoken.com;

	location / {
		proxy_pass http://127.0.0.1:8000;    
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_cache_bypass $http_upgrade;
    proxy_set_header HOST $host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
    access_log /home/www/shared/log/parse.usertoken-access.log;
    error_log /home/www/shared/log/parse.usertoken-error.log;
    error_page 404 /404.html;
}

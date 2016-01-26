
server {

	root /home/alex/shell.usertoken.com;
	index index.html index.htm;

	server_name shell.usertoken.com;

	location / {
		proxy_pass http://127.0.0.1:7000;    
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
	}
    access_log /home/alex/shared/log/shell.usertoken-access.log;
    error_log /home/alex/shared/log/shell.usertoken-error.log;
    error_page 404 /404.html;
}

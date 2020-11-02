server {
  listen 80 default_server;
  listen [::]:80 default_server;
  root /var/www/pabloaritz.com;
  index index.html index.php php/index.php;
  server_name pabloaritz.com www.pabloaritz.com;
  location / {
    try_files $uri $uri/ =404;
  }
    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/run/php/php7.4-fpm.sock;
    }

    location ~ /\.ht { 
        deny all;
    }
    # Return an empty response, used by dash.js to sync with server time
    location /time {
        return 200;
    }

    # DASH files
    location /dash/ {
            types {
                application/dash+xml mpd;
                video/mp4 mp4;
            }
            root /tmp;
            add_header Cache-Control no-cache;

            # CORS setup
            add_header 'Access-Control-Allow-Origin' '*' always;
            add_header 'Access-Control-Expose-Headers' 'Content-Length';
            
    }

        # HLS files
    location /hls/ {
    # Serve HLS fragments
    types {
        application/vnd.apple.mpegurl m3u8;
        video/mp2t ts;
    }
    root /tmp;
    add_header Cache-Control no-cache;
    add_header 'Access-Control-Allow-Origin' '*';
}

}

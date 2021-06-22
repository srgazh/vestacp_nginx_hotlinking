server {
    listen      %ip%:%proxy_port%;
    server_name %domain_idn% %alias_idn%;
    error_log  /var/log/httpd/domains/%domain%.error.log error;

    location / {
        proxy_pass      http://%ip%:%web_port%;
        location ~* ^.+\.(%proxy_extentions%)$ {
            root           %docroot%;
            access_log     /var/log/httpd/domains/%domain%.log combined;
            access_log     /var/log/httpd/domains/%domain%.bytes bytes;
            expires        max;
            try_files      $uri @fallback;
        location ~ \.(jpg|jpeg|png|gif|svg|mp4|mp3|pdf|zip|xmind)$ {
            valid_referers %domain_idn% %alias_idn%; if ($invalid_referer) { return 403; }
            }
        }
    }

    location /error/ {
        alias   %home%/%user%/web/%domain%/document_errors/;
    }

    location @fallback {
        proxy_pass      http://%ip%:%web_port%;
    }

    location ~ /\.ht    {return 404;}
    location ~ /\.svn/  {return 404;}
    location ~ /\.git/  {return 404;}
    location ~ /\.hg/   {return 404;}
    location ~ /\.bzr/  {return 404;}

    include %home%/%user%/conf/web/nginx.%domain%.conf*;
}

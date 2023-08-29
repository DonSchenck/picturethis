
# This script will replace the value in the appsettings.json file.
# This file is read by Blazor during startup.
# By replacing the value with the contents of the environment variable,
#   we are able to specify the picturethisapi webapi URL at runtime.
# E.g. podman run -e PICTURE_THIS_API_URL="https://foo/overlayImage" quay.io/donschenck/picturethisapi:latest

sed -i "s|foo|$PICTURE_THIS_API_URL|g" appsettings.json
nginx -g "daemon off;"
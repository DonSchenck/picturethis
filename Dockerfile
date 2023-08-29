FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY picturethis.csproj .
RUN dotnet restore picturethis.csproj
COPY . .
RUN dotnet build picturethis.csproj -c Release -o /app/build

FROM build AS publish
RUN dotnet publish picturethis.csproj -c Release -o /app/publish


FROM docker.io/nginx AS final
WORKDIR /usr/share/nginx/html
COPY --from=publish /app/publish/wwwroot .
COPY nginx.conf /etc/nginx/nginx.conf
RUN chown -R 1001:0 /var/cache/nginx && chmod -R ug+rwx /var/cache/nginx && chown -R 1001:0 /var/run
USER 1001
EXPOSE 5050
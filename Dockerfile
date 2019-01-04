FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app

# copy csproj and restore as distinct layers
COPY SampleWebApiAspNetCore/*.csproj ./dotnetapp/
WORKDIR /app/dotnetapp
RUN dotnet restore

# copy and publish app and libraries
WORKDIR /app/
COPY SampleWebApiAspNetCore/. ./dotnetapp/
WORKDIR /app/dotnetapp
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/dotnetapp/out ./
ENTRYPOINT ["dotnet", "SampleWebApiAspNetCore.dll"]


# docker build --pull -t dotnetapp .
# docker run -p 5000:80 --rm dotnetapp

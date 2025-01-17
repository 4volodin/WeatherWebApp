FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /source
COPY WeatherWebApp/WeatherWebApp/*.csproj ./
RUN dotnet restore
# copy everything else and build app
COPY WeatherWebApp/WeatherWebApp/. ./
WORKDIR /source/
RUN dotnet publish -c release -o /app --no-restore

FROM mcr.microsoft.com/dotnet/aspnet:6.0
WORKDIR /app
COPY --from=build /app ./
ENTRYPOINT ["dotnet", "WeatherWebApp.dll"]

﻿FROM mcr.microsoft.com/dotnet/core/sdk:3.1.300-bionic AS sdk
WORKDIR /app
ARG config=Release

COPY src ./src

RUN dotnet publish -c $config --no-self-contained src/*.sln

FROM mcr.microsoft.com/dotnet/core/aspnet:3.1.4-bionic
WORKDIR /app
COPY --from=sdk /app/_output/netcoreapp3.1/publish/. ./

# Docker Entry
ENTRYPOINT ["dotnet", "ServarrAuthAPI.dll"]

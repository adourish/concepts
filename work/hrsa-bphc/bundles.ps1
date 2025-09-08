
# PowerShell Script to Create Configuration Hub Folder Structure
# Root: C:\projects\configurationhub

Set-Location "C:\projects\configurationhub"

# Create root-level files and dirs
New-Item -ItemType Directory -Force -Path "src"
New-Item -ItemType File -Force -Path "index.html"
New-Item -ItemType File -Force -Path "styles.scss"
New-Item -ItemType File -Force -Path "assets\.empty"  # Placeholder for empty dir

# Create src/core/
New-Item -ItemType Directory -Force -Path "src/core/components/guards", "src/core/components/header", "src/core/components/resources", "src/core/components/skip-nav", "src/core/components/spinner", "src/core/components/toggler"
New-Item -ItemType Directory -Force -Path "src/core/models", "src/core/pipes", "src/core/services"
New-Item -ItemType File -Force -Path "src/core/constants.ts"
New-Item -ItemType File -Force -Path "src/core/star.core.provider.ts"

# Create src/features/
New-Item -ItemType Directory -Force -Path "src/features/tenants/routing", "src/features/tenants/components/tenant-list", "src/features/tenants/components/tenant-wizard", "src/features/tenants/data"
New-Item -ItemType Directory -Force -Path "src/features/form-registry/routing", "src/features/form-registry/components/form-registry-list", "src/features/form-registry/components/form-registry-wizard/form-api-features-table", "src/features/form-registry/data"
New-Item -ItemType Directory -Force -Path "src/features/resource-library/routing", "src/features/resource-library/components/resource-library-list", "src/features/resource-library/components/resource-library-wizard", "src/features/resource-library/data"
New-Item -ItemType Directory -Force -Path "src/features/cohorts/routing", "src/features/cohorts/components/cohorts-list", "src/features/cohorts/components/cohorts-wizard/resource-filter-step", "src/features/cohorts/data"
New-Item -ItemType Directory -Force -Path "src/features/resource-bundles/routing", "src/features/resource-bundles/components/resource-bundles-list", "src/features/resource-bundles/components/resource-bundles-wizard/forms-resources-step", "src/features/resource-bundles/components/resource-bundles-wizard/linked-resources-step", "src/features/resource-bundles/data"
New-Item -ItemType Directory -Force -Path "src/features/deliver-bundles/routing", "src/features/deliver-bundles/components/deliver-bundles-list", "src/features/deliver-bundles/components/deliver-bundles-wizard/schedule-step", "src/features/deliver-bundles/components/deliver-bundles-wizard/email-step", "src/features/deliver-bundles/data"

# Create src/layouts/
New-Item -ItemType Directory -Force -Path "src/layouts/app-layout", "src/layouts/full"

# Create src/shared/
New-Item -ItemType Directory -Force -Path "src/shared/components", "src/shared/models", "src/shared/pipes", "src/shared/directives"

# Create src/app* files
New-Item -ItemType File -Force -Path "src/app.component.ts", "src/app.component.html", "src/app.component.scss", "src/app-routing.module.ts", "src/app.module.ts", "src/main.ts"

# Touch .empty in empty dirs for visibility (optional)
Get-ChildItem -Directory -Recurse | Where-Object { -not $_.GetFiles() -and -not $_.GetDirectories() }  | ForEach-Object { New-Item -ItemType File -Force -Path "$($_.FullName)\.empty" }

Write-Host "Folder structure created under C:\projects\configurationhub"

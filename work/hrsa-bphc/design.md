Based on the provided structure, features, and components from the `features.md` and `code.txt` files (STAR application and Configuration Hub concepts), here is the designed folder structure and approach for implementing the app:

**High-Level Folder Structure**

```
src/
│
├── core/                                      // Shared, foundational code
│   ├── components/                           // Reusable base components & layouts
│   │   ├── guards/                           // Route guards
│   │   │   ├── task.guard.ts
│   │   │   └── correspondence.guard.ts       // If applicable to new app, or remove
│   │   ├── header/
│   │   │   ├── header.component.ts
│   │   │   ├── header.component.html
│   │   │   └── header.component.scss
│   │   ├── resources/
│   │   │   ├── resources.component.ts        // Main resources display
│   │   │   ├── resources.component.html
│   │   │   └── resources.component.scss
│   │   ├── skip-nav/                         // Accessibility
│   │   │   └── ... 
│   │   ├── spinner/                          // Global spinner
│   │   │   └── ...
│   │   └── toggler/                          // Generic toggler
│   │       └── ...
│   ├── models/                               // Shared data models
│   │   ├── filter-criteria.model.ts          // From STAR code
│   │   ├── form-status-update-data-args.model.ts // Potentially reusable concept
│   │   ├── return-status.model.ts            // Potentially reusable concept
│   │   └── ...                               // Other shared interfaces
│   ├── pipes/                                // Shared pipes
│   │   ├── keyvalue.pipe.ts
│   │   ├── show-in-overview.pipe.ts          // Potentially repurpose
│   │   ├── show-resource-link.pipe.ts        // Potentially repurpose
│   │   └── left-menu-filter-criteria.pipe.ts // Potentially repurpose or remove
│   ├── services/                             // Shared/core services
│   │   ├── app-start-config.service.ts       // Critical for bootstrapping and API URLs
│   │   ├── configuration.service.ts          // UI Config flags
│   │   ├── context.service.ts                // Potentially repurpose for general app state/context?
│   │   └── ...                               // Other core services like http interceptors if needed
│   └── constants.ts                          // App-wide constants
│   └── star.core.provider.ts                 // Core providers setup (Adapt for new app name)
│
├── features/                                 // Feature modules (aligned with Side-nav)
│   ├── tenants/                              // Feature 1
│   │   ├── tenants-routing.module.ts         // Route: `/tenants`
│   │   ├── tenants.component.ts/.html/.scss  // Main view component
│   │   ├── tenants.service.ts                // Feature-specific API calls
│   │   ├── data/                             // Feature-specific models
│   │   │   └── tenant.model.ts
│   │   ├── components/                       // Feature-specific child components
│   │   │   ├── tenant-list/
│   │   │   │   ├── tenant-list.component.ts/.html/.scss
│   │   │   │   └── tenant-list.datasource.ts // If using MatTableDataSource
│   │   │   └── tenant-wizard/                // Wizard component
│   │   │       ├── tenant-wizard.component.ts/.html/.scss
│   │   │       └── tenant-wizard.service.ts  // Steps logic, validation, API calls
│   │   └── tenants.module.ts                 // Declares/exports feature components, imports dependencies
│   │
│   ├── form-registry/                        // Feature 2
│   │   ├── form-registry-routing.module.ts
│   │   ├── form-registry.component.ts/.html/.scss
│   │   ├── form-registry.service.ts          // API: CRUD for form_registry, form_api_features, etc.
│   │   ├── data/
│   │   │   ├── form-registry.model.ts        // Interface for form_registry, form_api_features, etc.
│   │   │   └── form-views.model.ts           // Interface for form_views
│   │   ├── components/
│   │   │   ├── form-registry-list/
│   │   │   │   ├── form-registry-list.component.ts/.html/.scss
│   │   │   │   └── ...
│   │   │   └── form-registry-wizard/
│   │   │       ├── form-registry-wizard.component.ts/.html/.scss
│   │   │       ├── form-registry-wizard.service.ts
│   │   │       └── form-api-features-table/  // Sub-component for Step 2
│   │   │           ├── form-api-features-table.component.ts/.html/.scss
│   │   │           └── ...
│   │   └── form-registry.module.ts
│   │
│   ├── resource-library/                     // Feature 3
│   │   ├── resource-library-routing.module.ts
│   │   ├── resource-library.component.ts/.html/.scss
│   │   ├── resource-library.service.ts       // API: CRUD for resource_definitions, resource_items
│   │   ├── data/
│   │   │   └── resource-library.model.ts     // Interface for resource_definitions, resource_items
│   │   ├── components/
│   │   │   ├── resource-library-list/
│   │   │   │   ├── ...
│   │   │   │   └── ...
│   │   │   └── resource-library-wizard/
│   │   │       ├── ...
│   │   │       └── ...
│   │   └── resource-library.module.ts
│   │
│   ├── cohorts/                              // Feature 4
│   │   ├── cohorts-routing.module.ts
│   │   ├── cohorts.component.ts/.html/.scss
│   │   ├── cohorts.service.ts                 // API: CRUD for cohorts, linking resources
│   │   ├── data/
│   │   │   └── cohort.model.ts
│   │   ├── components/
│   │   │   ├── cohorts-list/
│   │   │   │   ├── ...
│   │   │   │   └── ...
│   │   │   └── cohorts-wizard/
│   │   │       ├── ...
│   │   │       ├── resource-filter-step/     // Component for Step 2 & 3
│   │   │       │   ├── resource-filter-step.component.ts/.html/.scss
│   │   │       │   └── ...
│   │   │       └── ...
│   │   └── cohorts.module.ts
│   │
│   ├── resource-bundles/                     // Feature 5
│   │   ├── resource-bundles-routing.module.ts
│   │   ├── resource-bundles.component.ts/.html/.scss
│   │   ├── resource-bundles.service.ts        // API: CRUD for resource_bundles, form_items, resource_items
│   │   ├── data/
│   │   │   └── resource-bundle.model.ts
│   │   ├── components/
│   │   │   ├── resource-bundles-list/
│   │   │   │   ├── ...
│   │   │   │   └── ...
│   │   │   └── resource-bundles-wizard/
│   │   │       ├── ...
│   │   │       ├── forms-resources-step/     // Component for Step 2 - List of forms
│   │   │       │   ├── forms-resources-step.component.ts/.html/.scss
│   │   │       │   └── ...
│   │   │       ├── linked-resources-step/    // Component for Step 3 - List of resources
│   │   │       │   ├── linked-resources-step.component.ts/.html/.scss
│   │   │       │   └── ...
│   │   │       └── ...
│   │   └── resource-bundles.module.ts
│   │
│   └── deliver-bundles/                      // Feature 6
│       ├── deliver-bundles-routing.module.ts
│       ├── deliver-bundles.component.ts/.html/.scss
│       ├── deliver-bundles.service.ts         // API: Handle delivery scheduling, communication
│       ├── data/
│       │   └── deliver-bundle.model.ts        // Schedule, email template, recipients, status
│       ├── components/
│       │   ├── deliver-bundles-list/
│       │   │   ├── ...
│       │   │   └── ...
│       │   └── deliver-bundles-wizard/
│       │       ├── ...
│       │       ├── schedule-step/             // Cron/One-time picker
│       │       │   ├── schedule-step.component.ts/.html/.scss
│       │       │   └── ...
│       │       ├── email-step/                // Template lookup, reminder days
│       │       │   ├── email-step.component.ts/.html/.scss
│       │       │   └── ...
│       │       └── ...
│       └── deliver-bundles.module.ts
│
├── layouts/                                  // Global layout components (using PFM)
│   ├── app-layout/
│   │   ├── app-layout.component.ts/.html/.scss
│   │   └── app-layout.module.ts              // Imports PFM layout modules
│   └── full/                                 // Specific layout if needed
│       └── ...
│
├── shared/                                   // Truly shared UI elements, utilities, modules
│   ├── components/                           // Reusable UI components not specific to core or a feature
│   │   └── ...
│   ├── models/                               // Widely used interfaces/pipes across features
│   │   └── ...
│   ├── pipes/                                // Widely used pipes (e.g., custom filters)
│   │   └── ...
│   ├── directives/                           // Custom directives
│   │   └── ...
│   └── shared.module.ts                      // Exports shared components/pipes/directives for import
│
├── app.component.ts/.html/.scss              // Root app component
├── app-routing.module.ts                     // Main routing delegating to feature modules
├── app.module.ts                             // Root module bootstrapping the app
├── main.ts                                   // Entry point bootstrapping AppModule
└── ...                                       // Other root-level files like index.html, styles.scss, assets/

```

**Implementation Approach for Features (Based on `features.md`)**

1.  **Core & Shared Setup:** Begin by copying and adapting `app-start-config.service.ts`, `configuration.service.ts`, core guards (as needed), pipes (as needed), `constants.ts`, and potentially `star.core.provider.ts` (renamed) for the new application. This establishes the foundational services and configuration handling.
2.  **App Structure:** Implement `app.component.ts/.html/.scss`, `app-routing.module.ts`, and `app.module.ts`. `app-routing.module.ts` should route to the main feature paths (e.g., `/tenants`, `/form-registry`). `app.component.html` should integrate PFM layout directives like `<pfm-topbanner>`, `<pfm-sidemenu>` (manually populated or driven by a service), `<router-outlet>`, and `<pfm-footer>`. Configure these via `layout.config.ts` if the pattern from STAR is reused/adapted, potentially leveraging `AppStartConfigService`.
3.  **Layout:** Implement the main `app-layout` component to house the common structure using PFM components. This is closely tied to the `app.component.html`.
4.  **Feature Modules:** Progress through the features.
    *   **Step 1:** Generate the feature module folder (e.g., `features/tenants`). Create its routing module and component.
    *   **Step 2:** Define the data models inside `data/`.
    *   **Step 3:** Create the main list component within `components/`. Implement the table using Angular Material components or suitable alternatives (STAR uses PFM, ensure PFM equivalents are used if available or stick to Material). Integrate live search/filter (`<input>` -> filter pipe or component logic), bulk-select (checkbox column + master checkbox), and inline actions (Edit/Delete buttons per row). Use the service to fetch data.
    *   **Step 4:** Create the main wizard component. Design a multi-step process (using Angular Material stepper or a custom implementation). Each step corresponds to a section in the flows described in `features.md`.
    *   **Step 5:** Implement validation within the wizard steps and the service methods for API interaction.
    *   **Step 6:** Wire up the "New/Register" button to open the wizard in create mode, and edit actions to load data into the wizard.
    *   **Step 7:** Implement wizard navigation buttons (Prev/Next/Finish/Cancel) with appropriate logic (hiding Prev on step 1, Finish only on last). Cancel should close the wizard. Finish should validate, call the service to save (create/update), close the wizard, and trigger a refresh of the list/data source.
    *   **Step 8:** Implement delete actions (single row and bulk) with confirmation dialogs (e.g., Angular Material Dialog).
    *   **Repeat:** Follow this pattern for `form-registry`, `resource-library`, `cohorts`, `resource-bundles`, and `deliver-bundles`.
5.  **PFM Components:** Ensure the following PFM (or equivalent UI) components/Pipes/Services are utilized correctly based on the STAR examples:
    *   **Layout Components:** `<pfm-topbanner>`, `<pfm-sidemenu>`, `<pfm-breadcrumbs>` (if used), `<pfm-footer>`. Layout configuration via `layout.config.ts` (if reused).
    *   **Core Services:** `PlatformHttp` (for API calls, if reused), `EventPublisher` (for communication, if reused), `AppStartConfigService` (for config), `ConfigurationService` (for UI flags).
    *   **UI Components:** Use equivalents from PFM (e.g., tables, buttons, modals/dialogs, forms, messages/toasts, grids) for the lists, wizards, inputs, search, and actions. Ensure proper import in `app.module.ts` or feature modules (checking `star.module.ts` imports). STAR uses NgbModal (NgBootstrap) for modals (e.g., `CheckInModalComponent`), which might be relevant.
    *   **Pipes:** Adapt or reuse `left-menu-filter-criteria.pipe.ts` for live filtering in tables if the logic fits. `ShowResourceLinkPipe`/`ShowInOverviewPipe` concepts might inspire filtering. `KeyValuePipe`.
    *   **Guards:** Use `TaskGuard` concept for route protection if needed (e.g., ensuring valid state before accessing a wizard step). `CorrrespondenceGuard` is likely specific to STAR.

This structure and approach provide a clear path to build the application as per the features outlined, leveraging a modular architecture, reusing core concepts from the STAR example (adapted for the new app's name and purpose), and integrating the specified PFM components where applicable.
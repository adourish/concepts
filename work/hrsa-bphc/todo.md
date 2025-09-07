---
base: c:\projects\concepts
---
# HRSA-BPHC Project To-Dos


# Form Library
- [~] ask: configuration hub
  - started: 2025-09-02 12:36 | know_tokens: 7532 | prompt_tokens: 7778 | total_tokens: 15310
  - include: pattern=*bundles-v26.html|*features.md recursive`
  - out: hrsa-bphc\bundles-library-v27.html
  - in: hrsa-bphc\bundles-library-v26.html
```knowledge

A0. look at bundles-v26.html. use this as your starting point
A4. DO NOT REMOVE ANY DATA. DO NOT REMOVE THE EXISTING FEATURES
A5. Do not remove any wizards 
A6. Do not remove any data
A7. Do not remove any features. 
     – Tenents
     – Submission Form Library  
     – Review Form Library
     - Tenents
     - Entities <-rename to Resources
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

task 1: add the form libraries feature
task 2: implement the wizard feature for Submission Form Library and Review Form Library
task 3: implement the data table and search feature for Submission Form Library and Review Form Library
task 4: add test data that is hrsa bphc themed

```

# Tenents
- [x] ask: configuration hub
  - started: 2025-09-02 12:44 | completed: 2025-09-02 12:45 | know_tokens: 7532 | prompt_tokens: 7685 | total_tokens: 15217
  - include: pattern=*bundles-v26.html|*features.md recursive`
  - out: hrsa-bphc\bundles-tenents-v27.html
  - in: hrsa-bphc\bundles-tenents-v26.html
```knowledge

A0. look at bundles-v26.html. use this as your starting point
A4. DO NOT REMOVE ANY DATA. DO NOT REMOVE THE EXISTING FEATURES
A5. Do not remove any wizards 
A6. Do not remove any data
A7. Do not remove any features. 
     – Tenents
     – Submission Form Library  
     – Review Form Library
     - Tenents
     - Entities <-rename to Resources
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

task 1: add the "Tenents" feature
task 2: implement the wizard Tenents
task 3: implement the data table and search feature for Tenents
task 4: add test data. Add HRSA\BPHC, HRSA\HAB, HRSA\BHW

```


# Cohorts
- [x] ask: configuration hub
  - started: 2025-09-02 12:46 | completed: 2025-09-02 12:47 | know_tokens: 7532 | prompt_tokens: 7685 | total_tokens: 15217
  - include: pattern=*bundles-v26.html|*features.md recursive`
  - out: hrsa-bphc\bundles-cohorts-v27.html
  - in: hrsa-bphc\bundles-cohorts-v26.html
```knowledge

A0. look at bundles-v26.html. use this as your starting point
A4. DO NOT REMOVE ANY DATA. DO NOT REMOVE THE EXISTING FEATURES
A5. Do not remove any wizards 
A6. Do not remove any data
A7. Do not remove any features. 
     – Tenents
     – Submission Form Library  
     – Review Form Library
     - Tenents
     - Resources 
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

task 1: add the Cohorts feature
task 2: implement the wizard feature for Cohorts
task 3: implement the data table and search feature for Cohorts
task 4: add test data that is hrsa bphc themed

```

# Bundles
- [x] ask: configuration hub
  - started: 2025-09-04 04:05 | completed: 2025-09-04 04:07 | know_tokens: 7322 | prompt_tokens: 0 | total_tokens: 7325
  - include: pattern=*bundles-v26.html|*features.md recursive`
  - out: bundles-bundles-v27.html
  - in: bundles-bundles-v26.html
```knowledge
review the features.md
change bundles-bundles-v26.html
task 0: change the side menu to match the features 
task 1: add the Resource Bundles feature
task 2: implement the wizard feature for Bundles
task 3: implement the data table and search feature for Bundles
task 4: add test data that is hrsa bphc themed

```

# Scope
- [x] ask: scope
  - started: 2025-09-01 00:17 | completed: 2025-09-01 00:23 | know_tokens: 3098 | prompt_tokens: 4383 | total_tokens: 7481
  - include: pattern=*scope-review-v3.html|*features.md recursive`
  - out: hrsa-bphc\scope-review-v4.html
  - in: hrsa-bphc\scope-review-v3.html
```knowledge




```

# Angular test
- [x] ask: scope
  - started: 2025-09-06 03:41 | knowlege_tokens: 556 | include_tokens: 94918 | in_tokens: 0 | prompt_tokens: 95474
  - include: pattern=*design.md|*code.txt|*features.md recursive`
  - out: angular-v1.html
  - in: angular-v1.html
```knowledge

1. review the design.md features.md and code.txt examples in code.txt
2. create each of the files needed to build the app
3. create each of the features in features.md
4. ensure to use the <pfm- components 
5. create all of the angular files needed for the app

1) Deliverable scope
- You want a complete, runnable Angular project (all files/modules/components/services/routing/styles), not just a skeleton. Confirmed: yes.

2) Angular / workspace
- Target Angular 19, single Angular CLI app (not Nx). Confirmed.

3) PFM libraries
- pfm-ui / pfm-layout / pfm-dcf etc. are provided separately. I’ll consume them as external packages (import paths as in STAR) and also include lightweight local stubs/mocks for any missing types/components so the project builds even if the real bundle is not installed.

4) Backend API availability
- No real APIs yet. You’ll implement them later. I’ll design services with typed interfaces and BaseUrl wiring via AppStartConfigService and provide an in-memory / mocked implementation (and HTTP service adapters) so the UI is fully runnable. When real endpoints exist you can switch the base URLs.

5) Authentication / startup config
- Default: I will include a development startup config token pattern in main.ts / assets (dev token + APIConfig) so the app boots in dev mode. I will structure the AppStartConfigService so it’s straightforward to swap for a real OAuth/JWT flow. 
- Clarify: do you prefer I ship the dev token startup config by default, or implement a placeholder “real auth” flow (redirect/OIDC wiring) now?
i will take care of auth stuff
6) Fidelity & feature priority
- Implementation fidelity: mock/local implementations with realistic interfaces and TODOs for wiring to real APIs. Services will include interfaces and example HTTP calls wired to AppStartConfigService base URLs.
- Priority order: implement Tenants fully first, then Form Registry, then Resource Library → Cohorts → Resource Bundles → Deliver Bundles. Confirmed.

7) Tests
- You left tests blank. I will NOT generate unit/e2e tests by default. (They can be added later.)
- Clarify: do you want unit tests / e2e generated now (basic Jasmine/Karma and Cypress/Playwright)? — yes / no?
no tests
8) Output format
- You want the files pasted here. I will paste the project files (multiple messages) in a GitHub-like layout.

9) Styling / theme
- Reuse the included core.scss and layout.config (adapt/trim where needed). Confirmed.

10) CI / lint / build
- No strict TypeScript / ESLint / Prettier requirements. I will provide a standard Angular 19 tsconfig.json (strict false) and a basic ESLint config (optional) but will not enforce CI pipeline files unless you request them.

Next steps I’ll take after you confirm:
- Generate the full Angular 19 project scaffold (app + core + shared + features) and implement Tenants feature end-to-end (list, search, bulk-select, wizard create/edit, mock service, routing, styles).
- Then deliver Form Registry skeleton + examples and the remaining feature module scaffolds.
- Provide README with how to bootstrap, where to swap real APIs, and how to switch auth.

Please confirm the two questions:
A) Auth startup behavior: keep dev startup config (dev token) by default, or wire a placeholder real auth/OIDC flow now?
no auth startup
B) Tests: do you want unit tests / e2e tests generated with the scaffold?
no unit tests
Once you confirm A + B I’ll start generating the files, beginning with Tenants.
```


# Scope
- [~] ask: star to react
  - started: 2025-09-06 14:10 | knowlege_tokens: 17 | include_tokens: 65276 | in_tokens: 3 | prompt_tokens: 65296 | cur_model: x-ai/grok-code-fast-1
  - include: *code.txt|*features.md recursive`
  - out: star-v2.html
  - in: star-v1.html
```knowledge

1. loop through each of the code.txt examples for star
2. convert each one to react components


```

# Scope
- [x] ask: star to react
  - started: 2025-09-06 17:57 | knowlege_tokens: 54 | include_tokens: 65276 | in_tokens: 3 | prompt_tokens: 65333 | cur_model: x-ai/grok-code-fast-1
  - include: *code.txt|*features.md recursive`
  - out: star-v4.html
  - in: star-v4.html
```knowledge

1. loop through the in react components
2. for each one that has rest of code, go into the code.txt and find all of gthe custom angular code
3. finish the react component based on the features.md
4. use <pfm- components where possible
5. verify that all lines of code from angular are converted

```

# config hub folder
- [x] ask: star to react
  - started: 2025-09-06 18:11 | knowlege_tokens: 15 | include_tokens: 19801 | in_tokens: 3 | prompt_tokens: 19819 | cur_model: x-ai/grok-code-fast-1
  - include: *design.md|*features.md recursive`
  - out: bundles.ps1
  - in: ''
```knowledge
create / touch the folder structure described in design.md
c:\projects\configurationhub will be the root folder
```
# HRSA-BPHC Project To-Dos

# Bundles
- [x] ask: enhance the user workflow for
  - started: 2025-08-31 14:49 | completed: 2025-08-31 14:52 | know_tokens: 3116 | prompt_tokens: 4211 | total_tokens: 7327
  - include: pattern=*bundles-v24.html recursive`
  - focus: file=C:\projects\concepts\work\hrsa-bphc\bundles-v25.html
```code
A0. enhance bundles-v24.html
A1. Update the Wizard Step Details for each of the main features
     – Submission Form Library  
     – Review Form Library  
A3. Give me a better way to enter the api features. each feature needs a way to update the feature, api, and verb. Use postman as an example. 
A4. Do not change any features. do not remove the wizards of page actions
     – Submission Form Library  
     – Review Form Library  
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

REFERENCE FEATUES: existing features: Do not remove
- Menu Navigation  
   • Accessible from global nav → “Configuration Hub”  
   • Side-Nav (always visible):  
     – Submission Form Library  
     – Review Form Library  
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

- High-Level User Flow  
   1. User lands on Configuration Hub (requires authentication)  
   2. Page loads Header (title, user menu), Side-Nav, Main area defaults to Submission Library  
   3. User clicks a Side-Nav link → section view loads  
   4. In each section:  
      a. [New/Register] button  
      b. Search box (live-filter)  
      c. Select-all checkbox + per-row checkboxes  
      d. Table of items with Actions (Update, Delete)  
   5. User actions in section:  
      • Search → filters rows immediately  
      • Select-all → toggles every row checkbox  
      • Click Delete (row) → confirms? → removes item → refresh table  
      • Click Update (row) → opens wizard in edit mode  
      • Click New/Register → opens wizard in create mode  
   6. Wizard overlay common behavior:  
      • Multi-step (2–4 steps, see below)  
      • Prev / Next / Finish / Cancel buttons (Prev hidden on step 1; Finish only on last step)  
      • Cancel → closes without saving  
      • Finish → validate required fields → save create/update → close → refresh table  
   7. After wizard closes user returns to section view; may switch sections or log out  

- Features & Behaviors  
   • Responsive layout (desktop/tablet)  
   • Live search/filtering  
   • Bulk select + bulk delete (if at least one checkbox)  
   • Inline row actions (Update, Delete)  
   • Wizard flows with field-level validation, progress indicators  
   • Conditional steps (e.g. “Enable Review” toggle skips review-form selection)  
   • Reordering lists in wizards (Up/Down controls)  
   • Cron or one-time schedule picker for deliverables  
   • Email template lookup + reminder-days input  

- Data Objects & Table Columns  

  - Submission Form Library
    • id (UUID)  
    • name (string)  
    • endpointUrl (string)  
    • authType (e.g. OAuth2, API Key)  
    • schema (JSON schema name/reference)  
    • lastValidationStatus (Passed/Failed/Pending)  
    • createdAt, updatedAt (timestamps)  
    Table columns:  
      – checkbox  
      – Name  
      - Description
      – Endpoint URL  
      – Exit Event
      - API Auth Type
      - APIs Features
        - Column should show which features are supported in a comma separated list (Create Draft, Update Draft, List Forms, Get Form Details, Delete Form, List Versions, Get Version, , Restore Version, Health)
        - The wizard should show a grid to allow configuring the features.
        - Create Draft POST /api/forms  
        - Update Draft PUT /api/forms/{formId}  
        - Publish POST /api/forms/{formId}/publish  
        - List Forms GET /api/forms?type={submission|review}&status={draft|published}&page={n}&size={m}  
        - Get Form Details GET /api/forms/{formId}  
        - Delete Form DELETE /api/forms/{formId}  
        - List Versions GET /api/forms/{formId}/versions  
        - Get Version Details GET /api/forms/{formId}/versions/{version}  
        - Restore Version → new draft from v POST /api/forms/{formId}/versions/{version}/restore
        - Health GET /api/health
      – Schema (YAML)  
      – Validation Status  
      - Options
      – Actions  

  - Review Form Library
    • same fields as Submission Form  
    Table columns same as Submission Library  

  - Cohort  
    • id  
    • name  
    • description  
    • tags (list of strings)  
    • programId (ref)  
    • entityType (e.g. User, Device)  
    • entityCount (computed)  
    • createdAt, updatedAt  
    Table columns:  
      – checkbox  
      – Name  
      – Description  
      – Tags  
      – Program  
      – Entity Type  
      – # Entities  
      – Actions  

  - Bundle (v19 schema)  
    • id  
    • name  
    • description  
    • programId  
    • tags (list)  
    • submissionPhaseForms (ordered list of formIds)  
    • reviewEnabled (bool)  
    • reviewPhaseForms (ordered list)  
    • createdAt, updatedAt  
    Table columns (for both Submission Bundles & Review Bundles views):  
      – checkbox  
      – Name  
      - Features
      – Endpoint URL  
      – Exit Event
      - API Auth Type
      - API Features
        - Create Draft POST /api/forms  
        - Update Draft PUT /api/forms/{formId}  
        - Publish POST /api/forms/{formId}/publish  
        - List Forms GET /api/forms?type={submission|review}&status={draft|published}&page={n}&size={m}  
        - Get Form Details GET /api/forms/{formId}  
        - Delete Form DELETE /api/forms/{formId}  
        - List Versions GET /api/forms/{formId}/versions  
        - Get Version Details GET /api/forms/{formId}/versions/{version}  
        - Restore Version → new draft from v POST /api/forms/{formId}/versions/{version}/restore
      – Schema (YAML)  
      – Validation Status  
      - Options
      – Actions  

  - Deliverable  
    • id  
    • name  
    • cohortId  
    • bundleId  
    • scheduleType (One-time / Recurring)  
    • scheduledDate (date if one-time)  
    • cronExpression (if recurring)  
    • notificationTemplateId  
    • reminderDays (array of ints)  
    • nextRun (computed)  
    • lastRunStatus (Success/Failure/Pending)  
    • createdAt, updatedAt  
    Table columns:  
      – checkbox  
      – Name  
      – Cohort  
      – Bundle  
      – Schedule (display human-readable)  
      – Next Run  
      – Status  
      – Actions  

- Wizard Step Details  

  - Form Wizard (Submission & Review) – 2 steps  
    Step 1: Metadata  
      • Name (required)  
      • Endpoint URL (required, URL format)  
      • Auth Type (dropdown) + credentials fields  
      * API Features table with features
      • Schema (dropdown)  
    Step 2: Validation  
      • Run Validation Tests button → shows status/messages  
      • Read-only view of entered metadata  
      • Finish  

  - Cohort Wizard – 4 steps  
    1. Basic Info (Name, Description, Tags)  
    2. Program & Entity Type (dropdowns)  
    3. Pick Entities (multi-select list filtered by step 2)  
    4. Review & Finish  

  - Bundle Wizard – 4 steps  
    1. Basics (Name, Description, Program, Tags)  
    2. Submission Phase  
       – Search field → filter available submission forms  
       – Checkboxes to add → appear in “Selected” list  
       – Up/Down to reorder  
    3. Review Phase  
       – Enable Review? (toggle)  
       – If on: same pattern with review forms  
    4. Summary & Finish  

  - Deliverable Wizard – 4 steps  
    1. Basic Info (Name, Cohort picker, Bundle picker)  
    2. Schedule (One-time date picker OR cron expression input + helper)  
    3. Notifications (Email template picker, Reminder days multi-select)  
    4. Review summary & Finish  

- Validation Rules & Error Handling  
   • All required fields enforced before Next/Finish  
   • Inline field errors + summary at top on validation fail  
   • Wizard cannot proceed if any step invalid  
   • Delete actions prompt confirmation dialog  

- State Management & Persistence  
   • Table views fetch paged data via REST API  
   • Searches apply query param to API calls  
   • Wizards maintain local state until Finish  
   • Create/update calls return updated object → table refresh  
```
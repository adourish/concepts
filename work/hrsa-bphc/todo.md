# HRSA-BPHC Project To-Dos

# Bundles
- [x] ask: enhance the user workflow for
  - started: 2025-08-31 14:04 | completed: 2025-08-31 14:05 | know_tokens: 2075 | prompt_tokens: 3056 | total_tokens: 5131
  - include: pattern=*bundles-v20.html recursive`
  - focus: file=C:\projects\concepts\work\hrsa-bphc\dist\bundles-v21.html
```code
A0. enhance bundles-v20.html
A1. only change ubmission Library  Review Library 
A2. add/update the column types in Submission Library  Review Library 
A3. Check that you did not remove any feautes


REFERENCE FEATUES: existing features: Do not remove
1. Menu Navigation  
   • Accessible from global nav → “Configuration Hub”  
   • Side-Nav (always visible):  
     – Submission Library  
     – Review Library  
     – Cohorts  
     – Submission Bundles  
     – Review Bundles  
     – Deliverables  

2. High-Level User Flow  
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

3. Features & Behaviors  
   • Responsive layout (desktop/tablet)  
   • Live search/filtering  
   • Bulk select + bulk delete (if at least one checkbox)  
   • Inline row actions (Update, Delete)  
   • Wizard flows with field-level validation, progress indicators  
   • Conditional steps (e.g. “Enable Review” toggle skips review-form selection)  
   • Reordering lists in wizards (Up/Down controls)  
   • Cron or one-time schedule picker for deliverables  
   • Email template lookup + reminder-days input  

4. Data Objects & Table Columns  

  4.1 Submission Form  
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
      - Features
      – Endpoint URL  
      – Exit Event
      - API Auth Type
      - APIs
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

  4.2 Review Form  
    • same fields as Submission Form  
    Table columns same as Submission Library  

  4.3 Cohort  
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

  4.4 Bundle (v19 schema)  
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
      - APIs
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

  4.5 Deliverable  
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

5. Wizard Step Details  

  5.1 Form Wizard (Submission & Review) – 2 steps  
    Step 1: Metadata  
      • Name (required)  
      • Endpoint URL (required, URL format)  
      • Auth Type (dropdown) + credentials fields  
      • Schema (dropdown)  
    Step 2: Validation  
      • Run Validation Tests button → shows status/messages  
      • Read-only view of entered metadata  
      • Finish  

  5.2 Cohort Wizard – 4 steps  
    1. Basic Info (Name, Description, Tags)  
    2. Program & Entity Type (dropdowns)  
    3. Pick Entities (multi-select list filtered by step 2)  
    4. Review & Finish  

  5.3 Bundle Wizard – 4 steps  
    1. Basics (Name, Description, Program, Tags)  
    2. Submission Phase  
       – Search field → filter available submission forms  
       – Checkboxes to add → appear in “Selected” list  
       – Up/Down to reorder  
    3. Review Phase  
       – Enable Review? (toggle)  
       – If on: same pattern with review forms  
    4. Summary & Finish  

  5.4 Deliverable Wizard – 4 steps  
    1. Basic Info (Name, Cohort picker, Bundle picker)  
    2. Schedule (One-time date picker OR cron expression input + helper)  
    3. Notifications (Email template picker, Reminder days multi-select)  
    4. Review summary & Finish  

6. Validation Rules & Error Handling  
   • All required fields enforced before Next/Finish  
   • Inline field errors + summary at top on validation fail  
   • Wizard cannot proceed if any step invalid  
   • Delete actions prompt confirmation dialog  

7. State Management & Persistence  
   • Table views fetch paged data via REST API  
   • Searches apply query param to API calls  
   • Wizards maintain local state until Finish  
   • Create/update calls return updated object → table refresh  
```
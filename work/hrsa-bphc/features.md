# Title: Configuration Hub

## Menu Navigation  
   Global Nav → “Configuration Hub”  
   Side-Nav (always visible):  
     Tenants  
     Form Registry  
     Resource Library  
     Cohorts  
     Resource Bundles  
     Deliver Bundles  

## High-Level User Flow  
   User lands on Configuration Hub (requires auth) → header + side-nav + main area (defaults to Submission Library)  
   Click side-nav → load that section view  
   Each section view provides:  
     [New/Register] button  
     Search box (live-filter)  
     Bulk-select checkbox + per-row checkboxes  
     Table of items with inline Actions (Update | Delete)  
   Actions:  
     Search → live filters rows  
     Select-all → toggles every row  
     Delete (row) → confirm → delete → refresh table  
     Update (row) → open wizard in edit mode  
     New/Register → open wizard in create mode  
   Wizard overlay (all sections)  
     Multi-step (2–4 steps per flow)  
     Prev / Next / Finish / Cancel buttons (Prev hidden on step 1; Finish only on last step)  
     Cancel → close without saving  
     Finish → validate required fields → save create/update → close → refresh table  
   After wizard closes, return to section view  

## Common Features  
   Responsive layout (desktop/tablet)  
   Live search/filtering  
   Bulk select + bulk delete  
   Inline row actions (Update, Delete)  
   Wizard flows with field-level validation + progress indicator  
   Conditional steps (e.g. Enable Review toggle)  
   Reordering lists in wizards (Up/Down)  
   Cron or one-time schedule picker (deliver bundles)  
   Email template lookup + reminder days input  

---

# FORM REGISTRY FLOW

## Form Registry Page Actions  
   Register New Form  
   Delete Selected  
   Search Forms  

## Database Objects

form_registry  
   id (UUID, PK)  
   name (varchar, NOT NULL)  
   description (text)  
   program_id (FK)  
   tenant_id (FK)  
   tags (varchar[])  
   entry_endpoint_url (varchar)  
   exit_event (varchar)  
   auth_type (varchar)  
   schema (varchar)  
   last_validation_status (ENUM: Passed, Failed, Pending)  
   created_at (timestamp)  
   updated_at (timestamp)  

form_api_features  
   id (UUID, PK)  
   form_id (FK → form_registry)  
   name (varchar)  
   url (varchar)  
   type (varchar)  
   headers (json)  
   query_params (json)  

form_options  
   id (UUID, PK)  
   form_id (FK → form_registry)  
   name (varchar)  
   description (text)  
   type (varchar)  
   default_value (varchar)  

form_views  
   id (UUID, PK)  
   form_id (FK → form_registry)  
   name (varchar)  
   description (text)  

## Form Registry Table Columns  
[checkbox] | ID | Name | Program | Tenant | Tags | Description | Entry Endpoint URL | Exit Event | Auth Type | Impact | API Features | Options | Views | Last Validation Status | Created At | Updated At | Actions  

## Form Registry Wizard  
Step 1: Metadata  
   name (required)  
   description (required)  
   program  
   tenant  
   entry_endpoint_url (required, URL format)  
   auth_type  
   exit_event  

Step 2: API Features  
   Table of feature rows (createDraft, health, search, getById, delete, patch, update, history) → set url, type, headers, query_params  

Step 3: Options  
   Table of option rows (name, description, type, default_value)  

Step 4: Validation  
   Run Validation Tests button → show status/messages  
   Read-only view of entered metadata  
   Finish  

---

#  RESOURCE LIBRARY FLOW

## Database Objects

resource_definitions  
   id (UUID, PK)  
   name (varchar, NOT NULL)  
   description (text)  
   resource_type (varchar)    -- e.g. application, award, organization, program  
   tenant_id (FK)  
   program_id (FK)  
   tags (varchar[])  
   created_at (timestamp)  
   updated_at (timestamp)  

resource_items  
   id (UUID, PK)  
   resource_definition_id (FK → resource_definitions)  
   content (text or json)  
   tags (varchar[])  
   scope_type (varchar)     -- system | user  
   created_at (timestamp)  
   updated_at (timestamp)  

## Resource Library Table Columns  
[checkbox] | ID | Name | Description | Resource Type | Tags | Tenant | Program | Scope Type | Created At | Updated At | Actions  

## Resource Library Wizard  
Step 1: Metadata  
   name (required)  
   description (required)  
   tags  
   tenant  
   program  
   Finish  

---

# COHORTS FLOW

## Database Object

cohorts  
   id (UUID, PK)  
   name (varchar, NOT NULL)  
   description (text)  
   tenant_id (FK)  
   program_id (FK)  
   tags (varchar[])  
   resource1_name (varchar)  
   resource2_name (varchar)  
   resource1_filter (json)  
   resource2_filter (json)  
   resource1_content (json list)  
   resource2_content (json list)  
   resource_count (int, computed)  
   created_at (timestamp)  
   updated_at (timestamp)  

## Cohorts Table Columns  
[checkbox] | ID | Name | Description | Tags | Program | Tenant | Resource Count | Created At | Updated At | Actions  

## Cohort Wizard  
Step 1: Metadata  
   name (required)  
   description (required)  
   program (multi-select)  
   tenant (select one)  
   resource1_name (select resource)  
   resource2_name (select resource)  
   tags  

Step 2: Resource1 Filter  
   Table of Resource Library items (Name, Tenant, Program, Tags) → filter/search → select  

Step 3: Resource2 Filter  
   Table of Resource Library items → filter/search → select  

Step 4: Summary (read-only metadata + selected content)  
   Finish  

---

# TENANTS FLOW

## Database Object

tenants  
   id (UUID, PK)  
   name (varchar, NOT NULL)  
   description (text)  
   program_id (FK)  
   created_at (timestamp)  
   updated_at (timestamp)  

## Tenants Table Columns  
[checkbox] | ID | Name | Description | Program | Created At | Updated At | Actions  

## Tenant Wizard  
Step 1: Metadata  
   name (required)  
   description (required)  
   program  

Step 2: Summary (read-only)  
   Finish  

---

# RESOURCE BUNDLES FLOW

## Database Object

resource_bundles  
   id (UUID or string, PK)  
   identifier (varchar, optional)  
   type (varchar, always “collection”)  
   timestamp (timestamp)  
   meta_version_id (varchar)  
   meta_last_updated (timestamp)  
   meta_implicit_rules (varchar)  
   total (unsignedInt, optional, defaults to count of entries)  
   signature (text or json)  
   created_at (timestamp)  
   updated_at (timestamp)  

form_items
   form_id (FK → form_registry)  
   order_index (int)  
   configured_options (json)  

resource_items
   bundle_id (FK → resource_bundles)  
   resource_id (FK → resource_definitions or resource_items)  
   order_index (int)  

## Resource Bundles Table Columns  
[checkbox] | ID | Type | Identifier | Timestamp | Total Entries | Forms Count | Resources Count | Last Updated | Actions  

## Resource Bundle Wizard  
Step 1: Basics  
   identifier (optional)  
   type (collection)  
   timestamp (defaults to now; editable)  
   meta_version_id (auto)  
   meta_last_updated (auto)  
   meta_implicit_rules (URI)  

Step 2: Forms & Context Resources  
   Search/Add Forms (grid of form_registry entries)  
  For each selected form, ability to click update. Select and change options, select and change the view, 
   Selected Forms list → reorder (Up/Down)  

Step 3: Linked Context Resources  
   Search Resource Library items (Name, Type, Program, Tenant, Tags)  
   Selected Resources list → reorder (Up/Down)  

Step 4: Metadata & Signature  
   total (auto = count of forms; editable)  
   signature (upload or paste)  

Step 5: Summary & Save  
   Read-only summary of all sections  
   Back to any step for edits  
   Save (POST for new, PUT for existing)  
   Cancel (warn if unsaved)  


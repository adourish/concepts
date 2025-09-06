Below is a high-level design for a brand-new Angular “Configuration Hub” app, built with Angular CLI and Angular Material. It matches the 6-item side nav and wizard-based CRUD flows you sketched, but with full folder organization, separation of concerns, and a shared wizard component to DRY up common logic.

----------------------------------------------------------------------------
1) Project Scaffold  
----------------------------------------------------------------------------
ng new config-hub  
cd config-hub  
ng add @angular/material  

----------------------------------------------------------------------------
2) Folder & Module Structure  
----------------------------------------------------------------------------
src/
 ├── app/
 │    ├── core/                      # singleton services, interceptors, guards, models
 │    │    ├── services/
 │    │    │    ├── tenant.service.ts
 │    │    │    ├── form-registry.service.ts
 │    │    │    │   ⋮
 │    │    ├── models/
 │    │    │    ├── tenant.model.ts
 │    │    │    ├── form.model.ts
 │    │    │    ├── resource.model.ts
 │    │    │    ├── cohort.model.ts
 │    │    │    ├── bundle.model.ts
 │    │    │    └── deliver-bundle.model.ts
 │    │    ├── guards/
 │    │    └── interceptors/
 │    │
 │    ├── shared/                    # reusable components, pipes, directives
 │    │    ├── components/
 │    │    │    ├── wizard/          # generic multi-step wizard
 │    │    │    │    ├── wizard.component.ts
 │    │    │    │    ├── wizard-step.directive.ts
 │    │    │    │    └── wizard.module.ts
 │    │    │    ├── table/           # generic table with search/select
 │    │    │    │    ├── data-table.component.ts
 │    │    │    │    └── table.module.ts
 │    │    │    └── confirm-dialog/  # confirm delete
 │    │    ├── pipes/
 │    │    └── shared.module.ts
 │    │
 │    ├── features/                  # 6 feature modules
 │    │    ├── tenants/
 │    │    │    ├── tenants-list/
 │    │    │    │    ├── tenants-list.component.ts
 │    │    │    │    └── tenants-list.component.html
 │    │    │    ├── tenant-wizard/
 │    │    │    │    ├── tenant-wizard.component.ts
 │    │    │    │    ├── steps/
 │    │    │    │    │    ├── metadata-step.component.ts
 │    │    │    │    │    └── summary-step.component.ts
 │    │    │    └── tenants.module.ts
 │    │    ├── form-registry/
 │    │    │    ├── form-registry-list.component.ts
 │    │    │    ├── form-registry-list.component.html
 │    │    │    ├── form-registry-wizard/
 │    │    │    │    ├── metadata-step.component.ts
 │    │    │    │    ├── api-features-step.component.ts
 │    │    │    │    ├── options-step.component.ts
 │    │    │    │    ├── validation-step.component.ts
 │    │    │    │    └── form-registry-wizard.component.ts
 │    │    │    └── form-registry.module.ts
 │    │    ├── resource-library/
 │    │    │    ├── resource-list.component.ts
 │    │    │    ├── resource-list.component.html
 │    │    │    ├── resource-wizard/
 │    │    │    └── resource.module.ts
 │    │    ├── cohorts/
 │    │    │    ├── cohorts-list.component.ts
 │    │    │    ├── cohort-wizard/
 │    │    │    └── cohorts.module.ts
 │    │    ├── resource-bundles/
 │    │    │    ├── bundles-list.component.ts
 │    │    │    ├── bundle-wizard/
 │    │    │    └── resource-bundles.module.ts
 │    │    └── deliver-bundles/
 │    │         ├── deliver-list.component.ts
 │    │         ├── deliver-wizard/
 │    │         └── deliver-bundles.module.ts
 │    │
 │    ├── layout/                    # header + side-nav + footer
 │    │    ├── header.component.ts
 │    │    ├── sidenav.component.ts
 │    │    └── layout.module.ts
 │    │
 │    ├── app-routing.module.ts      # eager-load feature modules
 │    └── app.component.ts
 └── assets/
 
----------------------------------------------------------------------------
3) Routing (app-routing.module.ts)  
----------------------------------------------------------------------------
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { TenantsListComponent } from './features/tenants/tenants-list/tenants-list.component';
import { FormRegistryListComponent } from './features/form-registry/form-registry-list.component';
// … import others …

const routes: Routes = [
  { path: '', redirectTo: '/tenants', pathMatch: 'full' },
  { path: 'tenants', component: TenantsListComponent },
  { path: 'form-registry', component: FormRegistryListComponent },
  { path: 'resource-library', loadChildren: () => import('./features/resource-library/resource.module').then(m=>m.ResourceModule) },
  { path: 'cohorts', loadChildren: () => import('./features/cohorts/cohorts.module').then(m=>m.CohortsModule) },
  { path: 'resource-bundles', loadChildren: () => import('./features/resource-bundles/resource-bundles.module').then(m=>m.ResourceBundlesModule) },
  { path: 'deliver-bundles', loadChildren: () => import('./features/deliver-bundles/deliver-bundles.module').then(m=>m.DeliverBundlesModule) },
];

@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}

----------------------------------------------------------------------------
4) Shared Table & Wizard Components  
----------------------------------------------------------------------------
// shared/components/table/data-table.component.ts
– Inputs: dataSource (any[]), columns (array of column defs), selection model  
– Outputs: rowEdit, rowDelete, bulkDelete  

// shared/components/wizard/wizard.component.ts
– @ContentChildren(WizardStepDirective) steps  
– Prev/Next/Finish/Cancel buttons appear automatically  
– Emits finish(formValue)  

Usage inside a feature wizard:  
```html
<app-wizard (finish)="onSave($event)">
  <ng-container wizardStep stepLabel="Metadata">
    <!-- form fields -->
  </ng-container>
  <ng-container wizardStep stepLabel="Features">
    <!-- step 2 fields -->
  </ng-container>
  <!-- ... -->
</app-wizard>
```

----------------------------------------------------------------------------
5) Feature List Component Example (Tenants)  
----------------------------------------------------------------------------
// features/tenants/tenants-list.component.ts
```ts
@Component({ /* … */ })
export class TenantsListComponent implements OnInit {
  tenants$: Observable<Tenant[]>;
  selected: Tenant[] = [];

  constructor(private svc: TenantService, private dialog: MatDialog) {}

  ngOnInit() {
    this.load();
  }

  load() {
    this.tenants$ = this.svc.getAll();
  }

  onNew() {
    const ref = this.dialog.open(TenantWizardComponent, { data: {} });
    ref.afterClosed().subscribe(() => this.load());
  }

  onEdit(t: Tenant) {
    const ref = this.dialog.open(TenantWizardComponent, { data: t });
    ref.afterClosed().subscribe(() => this.load());
  }

  onDelete(t: Tenant) {
    if (confirm(`Delete ${t.name}?`)) this.svc.delete(t.id).subscribe(()=>this.load());
  }

  onBulkDelete() { … }
}
```

// features/tenants/tenant-wizard.component.ts
```ts
@Component({ template: `  
  <app-wizard (finish)="save($event)">
    <ng-container wizardStep stepLabel="Metadata">
      <form [formGroup]="metaForm">
        <!-- name, description, program -->
      </form>
    </ng-container>
    <ng-container wizardStep stepLabel="Summary">
      <tenant-summary [data]="metaForm.value"></tenant-summary>
    </ng-container>
  </app-wizard>`})
export class TenantWizardComponent {
  metaForm = this.fb.group({ name: ['', Validators.required], description: ['', Validators.required], program: [''] });
  constructor(@Inject(MAT_DIALOG_DATA) public data: Tenant, private svc: TenantService, private fb: FormBuilder, private dialogRef: MatDialogRef<any>) {
    if (data && data.id) this.metaForm.patchValue(data);
  }
  save(val) {
    const obs = this.data.id
      ? this.svc.update(this.data.id, val)
      : this.svc.create(val);
    obs.subscribe(()=> this.dialogRef.close());
  }
}
```

----------------------------------------------------------------------------
6) Services (core/services/*)  
----------------------------------------------------------------------------
Each service uses HttpClient:
```ts
@Injectable({providedIn:'root'})
export class TenantService {
  private base = '/api/tenants';
  constructor(private http: HttpClient){ }
  getAll(): Observable<Tenant[]> { return this.http.get<Tenant[]>(this.base); }
  create(t: TenantCreate) { return this.http.post(this.base, t); }
  update(id: string, t: TenantCreate) { return this.http.put(`${this.base}/${id}`, t); }
  delete(id: string) { return this.http.delete(`${this.base}/${id}`); }
}
```
Repeat for FormRegistryService, ResourceService, CohortService, BundleService, DeliverBundleService.

----------------------------------------------------------------------------
7) Styling & Material Modules  
----------------------------------------------------------------------------
In each feature module:
```ts
@NgModule({
  imports: [
    CommonModule,
    ReactiveFormsModule,
    SharedModule,
    MatTableModule,
    MatFormFieldModule,
    MatInputModule,
    MatButtonModule,
    MatDialogModule,
    MatIconModule,
    MatPaginatorModule,
  ],
  declarations: [TenantsListComponent, TenantWizardComponent, /* steps */],
})
export class TenantsModule {}
```

----------------------------------------------------------------------------
8) Deployment & Next Steps  
----------------------------------------------------------------------------
• Back-end: Expose REST API endpoints matching core/services URLs  
• Wire up real HTTP calls and replace the stub arrays  
• Flesh out each wizard’s steps with your business fields/validation  
• Add paging, sorting in tables, mobile-responsive breakpoints  
• Secure via Angular guards + authentication interceptor  

With this structure you get:  
– Clear folder separation (core vs shared vs feature)  
– One shared wizard you reconfigure per flow  
– Reusable data-table for search / bulk-select / inline actions  
– Lazy loading of big features  
– Material provides modern look & feel  
– All CRUD & wizard flows separated into small, maintainable components.
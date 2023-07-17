          ┌────────────────┐
          │   Feature Env  │
          │     (Branch)   │
          └────────────────┘
                 │
                 ▼
          ┌────────────────┐ ◀── Pull Request
          │   Dev Env      │
          │  (Branch: dev) │
          │ (aws:cedc_glue)│
          └────────────────┘
                 │
                 ▼
          ┌────────────────┐    Pull Request
          │   QA Env       │◀── With Reviewer
          │ (Branch: main) │
          │     (Jacky)    │
          └────────────────┘
                 │
                 ▼
          ┌────────────────┐    Release Request
          │   Prod Env     │◀── With Approval
          │ (Branch: tag)  │
          │     (Cui)      │
          └────────────────┘

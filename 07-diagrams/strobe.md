**Participant Diagram**
*All Cohorts*
```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart TD
 A["`ALL Cohorts`"]
 B["`Ultrasound`"]
 C["`Fecal Elastase`"]
 D["`CT Scan`"]
 E["`FE and USS`"]
 F["`FE and CT`"]
 G["`No  USS`"]
 H["`No  FE`"]
 I["`No  CT`"]


A --> B
A --> C
A --> D
B --> E 
C --> E
C --> F
D --> F
B ---> G
C ---> H
D ---> I
```

**People Workflow**

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
    A["`HR Form 1: Contract Details
    HR`"]
    B["`HR Form 2 : Google Workspace Allocation
    HR`"]
    C["`HR Form 3 : Employee Info
    Hiree`"]
    D["`FIN Form 1 : Personnel Cost Centers
    Finance`"]
    E["`HR Internal Database
    HR`"]
    F["`Data for HRIS
    Output`"]
    G["`Data for Payroll
    Output`"]
    I["`HRIS
    HR`"]
    J["`Payroll System
    Finance`"]   
   
  A --> B --> C --> D --> E 
  E --> F --> I
  E --> G --> J
```
*Contract duration: This can be extended or a new contract is entered.  The revision can be in Form 1.*

**Projects Workflow**

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
    A["`Form Project1 : Project Registration
    Unit`"]
    B["`Form Project1 : Financial Details
    Finance`"]
    C["`Form Project2 : ED Approval
    ED`"]
    D["`Form Project2 : Finance Reports
    Finance`"]
    E["`Form Project3 : Project Reports
    Finance`"]
    F["`Form Project4 : Closure
    Unit
    Finance`"]
  
   
  A --> B --> C --> D
  C--> E --> F
  D--> F 
```
*Project duration: This can be extended or a new contract is entered.  The revision can be in Form 1.*

**Funds Workflow**
```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
    A["`Form Fund1 : Fund Request
    Unit Staff`"]
    B["`Form Fund1a : Fund Approval1
    Unit Head
    Project Leader`"]
    C["`Form Fund1b : Fund Approval2
    ED/President`"]
    D["`Form Fund1c : Fund Approval3
    Finance`"]
    E["`Form Fund2 : Fund Transfer Initiated 
    Acct1`"]
    F["`Form Fund2 : Fund Transfer Completed 
    Acct1`"]
    G["`Form Fund3 : Report Expense
    Unit Staff`"]
    H["`Form Fund3 : Liquidation
    Acct2`"]

  A --> B --> C --> E 
  B --> D --> E --> F --> G --> H
  
```

*ER Diagram Funds*

``` mermaid
erDiagram
    USER ||--o{ FUNDS : requests
    USER {
        string user
        string employeeid
        string project
    }
    FUNDS ||--|{ LINE-ITEM : contains
    FUNDS {
        int requestNumber
        string costCode
    }
    LINE-ITEM {
        string itemCode
        int quantity
        float pricePerUnit
    }
```

**Workflow for Inventory**

```mermaid
%%{init: {"flowchart": {"htmlLabels": false}} }%%
flowchart LR
    A["`Record Assets`"]
    B["`Assign Location`"]
    C["`Assign Custodian`"]
    D["`Generate MR`"]
    E["`Update Asset`"]
   
  A --> B --> C --> D --> E --> F 
```

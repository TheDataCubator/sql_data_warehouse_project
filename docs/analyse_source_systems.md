## Analyse Source Systems

Analyse source systems is the important steps to **understand the sources**. In some cases system experts will be interviewed to gain information about the source.
Asking the right question will help 
- to design the correct scripts in order to extract the data
- to avoid a lot of mistakes and challenges.

Below are the example of questions before starting data connections.

---
### Business Context & Ownership
❔ **Who owns the data?**<br>
(IT Dept,...)

❔ **What Business Process it supports?**<br>
(customer transactions, supply chains, logistics, finance reporting)

❔ **System & Data documentation**

❔ **Data Model & Data Catalog**<br>
(Description of Columns)

---

### Architecure & Technology Stack
❔ **How is data stored?**<br>
(SQL Server, Oracle, AWS, Azure,...)

❔ **What are the integration capabilities?**<br>
(API, Kafka, File Extract, direct DB connection,....)

---
### Extract & Load
❔ **Incremental vs. Full Loads?**

❔ **Data Scope & Historical Needs**<br>
(all data,10 years,...)

❔ **What is the expected size of the extracts?**<br>
(MB,GB,TB,...)

❔ **Are there any data volume limitations?**<br>
(old source systems might struggle with performance)

- ❔**How to avoid impacting the source system's performance?**<br>

- ❔**Authentication and authorization**<br>
(tokens, SSH keys, VPN, IP whitelisting,...)

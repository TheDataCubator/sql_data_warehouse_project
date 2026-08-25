/*
=======================================================
This is the important steps to understand the sources. In some cases we need to interview the system experts to ask them about the source.
Asking the right question will help to design the correct scripts in order to extract the data and to avoid a lot of mistakes and challenges.
=======================================================
*/

### Business Context & Ownership
- **Who owns the data?**<br>
(IT Dept,...)

- **What Business Process it supports?**<br>
(Customer transaction, Supply Chain, Logistics, Finance)

- **System & Data documentation**

- **Data Model & Data Catalog**<br>
(Description of Columns)

### Architecure & Technology Stack
- **How is data stored?**<br>
(SQL Server, Oracle, AWS, Azure,...)

- **What are the integration capabilities?**<br>
(API Kafka, File Extract, Direct DB,....)

### Extract & Load
- **incremental vs. Full Loads?**

- **Data Scope & Historical Needs**

- **What is the expected size of the extracts?**<br>
(size of the data)

- **Are there any data volume limitations?**

- **How to avoid impacting the source system's performance?**<br>
(not bringing the performance of the database down)

- **Authentication and authorization**<br>
(tokens, SSH keys, VPN, IP whitelisting,...)

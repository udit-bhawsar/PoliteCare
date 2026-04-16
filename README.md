# 💊 PoliteCare Pharmaceuticals – B2B Distribution Portal

PoliteCare Pharmaceuticals is a robust **Enterprise Micro-ERP** system built using Java and the Spring Framework. Designed specifically for pharmaceutical manufacturing units, this portal facilitates seamless bulk procurement transactions between the production plant and authorized regional stockists.

---

## 🚀 Key Industrial Logic & Features

- **🔐 Trade Privacy Gate:** Confidential wholesale (ex-factory) rates and purchase features are dynamically masked for guest users to protect business secrets.
- **📦 Industrial Bulk Ordering:** Customized procurement engine centered around **Boxes/Cartons** instead of retail units.
- **🛡️ Industrial MOQ Guard:** Integrated backend validation enforcing a **Minimum Order Quantity (MOQ) of 5 boxes** for every SKU to ensure logistical profitability.
- **⚡ Automated Stock Reconciliation:** Direct integration between Admin dispatch approval and warehouse inventory count via **Spring Data JPA**.
- **📑 Audit-Ready Invoicing:** Automatic generation of professional, GST-compliant digital Purchase Order (PO) invoices in print-ready format.
- **📊 Business Intelligence Dashboard:** High-level analytics for monitoring revenue trends, fast-moving medicine categories, and distributor contributions.

---

## 🛠️ Technology Stack

| Layer | Technologies Used |
| :--- | :--- |
| **Backend Core** | Java 17, Spring Framework 6.x (MVC) |
| **Persistence (ORM)** | Spring Data JPA, Hibernate 6 |
| **Database** | MySQL 8.0 (Relational Data Storage) |
| **Cloud Hosting** | **Render** (Application) & **Aiven** (Managed Database) |
| **Frontend UI** | JSP (JSTL), Bootstrap 5, FontAwesome 6 |
| **Deployment** | Docker Containerization |

---

## 🏗️ Project Architecture

The project strictly follows the **Model-View-Controller (MVC)** design pattern:
- **Models:** Entity mapping for Users, Medicines (Products), and bulk Orders.
- **Repositories:** JPA Interfaces handling atomic transactional queries and industrial joins.
- **Controllers:** High-concurrency routes for procurement flow, authentication gating, and admin logic.

---

## ☁️ Deployment Information (PaaS)

- **Application Platform:** [Render.com](https://render.com) (Docker based deployment).
- **Persistent Disk:** Mounted at `/data/uploads` for medicinal batch image storage.
- **Database Engine:** Managed MySQL Instance via [Aiven.io](https://aiven.io).

---

## 📄 Contact & Presentation Info
Developed as a **Major Final Year Project**.
- **Focus:** Digital Transformation of Pharma Supply-Chain (Industry 4.0).
- **Keywords:** B2B ERP, Pharmaceutical Logistics, Spring Framework, Cloud-Native Database.

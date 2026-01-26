---
layout: post
title: "Deploying Vaultwarden to Azure Container Apps - Complete Guide"
date: 2026-01-26
categories: [azure, security, devops]
tags: [vaultwarden, azure, container-apps, security, password-management]
---

# Deploying Vaultwarden to Azure Container Apps - Complete Task List

This is a comprehensive, step-by-step guide to deploying Vaultwarden (open-source Bitwarden server) to Azure Container Apps with production-grade security.

## Prerequisites Checklist

- [ ] Active Azure subscription with permissions to create resources
- [ ] Azure CLI installed ([Download here](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli))
- [ ] Basic understanding of password managers and containers
- [ ] (Optional) Custom domain name for production use
- [ ] Text editor for creating configuration files

## Phase 1: Azure Environment Setup

### Task 1.1: Install and Configure Azure CLI

```bash
# Install Azure CLI (if not already installed)
# macOS
brew update && brew install azure-cli

# Windows (PowerShell as Administrator)
# Invoke-WebRequest -Uri https://aka.ms/installazurecliwindows -OutFile .\AzureCLI.msi; Start-Process msiexec.exe -Wait -ArgumentList '/I AzureCLI.msi /quiet'

# Linux (Ubuntu/Debian)
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash

# Verify installation
az version
```

**Completion Criteria:** `az version` returns version information

---

### Task 1.2: Login to Azure

```bash
# Login to your Azure account
az login

# If you have multiple subscriptions, list them
az account list --output table

# Set the subscription you want to use
az account set --subscription "YOUR_SUBSCRIPTION_ID_OR_NAME"

# Verify current subscription
az account show --output table
```

**Completion Criteria:** You see your correct subscription information

---

### Task 1.3: Create Resource Group

```bash
# Set variables (customize these)
RESOURCE_GROUP="rg-vaultwarden-prod"
LOCATION="eastus"  # Change to your preferred region

# Create resource group
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION

# Verify creation
az group show --name $RESOURCE_GROUP --output table
```

**Completion Criteria:** Resource group visible in Azure Portal or CLI output

---

## Phase 2: Storage Account Setup (Data Persistence)

### Task 2.1: Create Storage Account

```bash
# Generate unique storage account name (must be globally unique, lowercase, no special chars)
STORAGE_ACCOUNT="stvaultwarden$RANDOM$RANDOM"
echo "Storage Account Name: $STORAGE_ACCOUNT" # Save this!

# Create storage account with security hardening
az storage account create \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --sku Standard_ZRS \
  --kind StorageV2 \
  --https-only true \
  --min-tls-version TLS1_2 \
  --allow-blob-public-access false \
  --access-tier Hot

# Verify creation
az storage account show \
  --name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --output table
```

**Completion Criteria:** Storage account created and shows in Azure Portal

---

### Task 2.2: Retrieve Storage Account Key

```bash
# Get storage account key (save this securely!)
STORAGE_KEY=$(az storage account keys list \
  --account-name $STORAGE_ACCOUNT \
  --resource-group $RESOURCE_GROUP \
  --query "[0].value" \
  --output tsv)

# Verify we got the key (should see long string)
echo "Storage key retrieved: ${STORAGE_KEY:0:10}..." # Shows first 10 chars only
```

**Completion Criteria:** Storage key retrieved (long alphanumeric string)

---

### Task 2.3: Create File Share for Vaultwarden Data

```bash
FILE_SHARE="vaultwarden-data"

# Create file share
az storage share create \
  --name $FILE_SHARE \
  --account-name $STORAGE_ACCOUNT \
  --account-key $STORAGE_KEY \
  --quota 10 \
  --access-tier "TransactionOptimized"

# Verify creation
az storage share show \
  --name $FILE_SHARE \
  --account-name $STORAGE_ACCOUNT \
  --account-key $STORAGE_KEY \
  --output table
```

**Completion Criteria:** File share visible in Storage Account → File shares in Azure Portal

---

### Task 2.4: Enable Soft Delete Protection

```bash
# Enable soft delete for file shares (7-day retention)
az storage account file-service-properties update \
  --account-name $STORAGE_ACCOUNT \
  --enable-delete-retention true \
  --delete-retention-days 7

# Verify soft delete is enabled
az storage account file-service-properties show \
  --account-name $STORAGE_ACCOUNT \
  --query "shareDeleteRetentionPolicy"
```

**Completion Criteria:** Soft delete retention policy shows as enabled

---

## Phase 3: Container Apps Environment Setup

### Task 3.1: Create Container Apps Environment

```bash
ENVIRONMENT_NAME="env-vaultwarden"

# Create Container Apps environment
az containerapp env create \
  --name $ENVIRONMENT_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION

# Verify creation
az containerapp env show \
  --name $ENVIRONMENT_NAME \
  --resource-group $RESOURCE_GROUP \
  --output table
```

**Completion Criteria:** Container App Environment visible in Azure Portal

---

### Task 3.2: Configure Storage Mount in Environment

```bash
STORAGE_MOUNT_NAME="vaultwarden-storage"

# Add storage to Container Apps environment
az containerapp env storage set \
  --name $ENVIRONMENT_NAME \
  --resource-group $RESOURCE_GROUP \
  --storage-name $STORAGE_MOUNT_NAME \
  --azure-file-account-name $STORAGE_ACCOUNT \
  --azure-file-account-key $STORAGE_KEY \
  --azure-file-share-name $FILE_SHARE \
  --access-mode ReadWrite

# Verify storage mount
az containerapp env storage show \
  --name $ENVIRONMENT_NAME \
  --resource-group $RESOURCE_GROUP \
  --storage-name $STORAGE_MOUNT_NAME \
  --output table
```

**Completion Criteria:** Storage mount shows in Container App Environment settings

---

## Phase 4: Security Configuration

### Task 4.1: Generate Admin Token

```bash
# Generate secure admin token (minimum 40 characters)
ADMIN_TOKEN=$(openssl rand -base64 48)

echo "========================================="
echo "⚠️  SAVE THIS ADMIN TOKEN SECURELY! ⚠️"
echo "========================================="
echo "$ADMIN_TOKEN"
echo "========================================="
echo ""
echo "This token is required to access /admin"
echo "Store it in a password manager NOW!"
echo ""

# Wait for user confirmation
read -p "Press Enter after saving the admin token..."
```

**Completion Criteria:** Admin token saved in secure location (password manager, vault, etc.)

---

### Task 4.2: (Optional) Prepare SMTP Settings for Email

If you want password reset emails and 2FA, configure SMTP settings:

```bash
# Example for SendGrid
SMTP_HOST="smtp.sendgrid.net"
SMTP_PORT="587"
SMTP_USERNAME="apikey"
SMTP_PASSWORD="YOUR_SENDGRID_API_KEY"  # Get from SendGrid
SMTP_FROM="noreply@yourdomain.com"
SMTP_SECURITY="starttls"

# Example for Gmail (App Password required)
# SMTP_HOST="smtp.gmail.com"
# SMTP_PORT="587"
# SMTP_USERNAME="your-email@gmail.com"
# SMTP_PASSWORD="your-app-password"
# SMTP_FROM="your-email@gmail.com"

echo "SMTP configured for: $SMTP_HOST"
```

**Completion Criteria:** SMTP credentials ready (skip if not using email features)

---

## Phase 5: Deploy Vaultwarden Container

### Task 5.1: Deploy Container App (Basic)

```bash
APP_NAME="vaultwarden"

# Create initial container app
az containerapp create \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --environment $ENVIRONMENT_NAME \
  --image vaultwarden/server:latest \
  --target-port 80 \
  --ingress external \
  --min-replicas 1 \
  --max-replicas 1 \
  --cpu 0.5 \
  --memory 1Gi \
  --secrets \
    admin-token="$ADMIN_TOKEN" \
  --env-vars \
    SIGNUPS_ALLOWED=true \
    ADMIN_TOKEN=secretref:admin-token

# Get the app URL
APP_URL=$(az containerapp show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "properties.configuration.ingress.fqdn" \
  --output tsv)

echo ""
echo "========================================="
echo "✅ Vaultwarden Deployed!"
echo "========================================="
echo "URL: https://$APP_URL"
echo "Admin Panel: https://$APP_URL/admin"
echo "========================================="
```

**Completion Criteria:** Can access Vaultwarden URL in browser

---

### Task 5.2: Add Storage Volume Mount

```bash
# Update container app to mount storage
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --set-env-vars \
    DOMAIN="https://$APP_URL" \
  --args ''

# Note: Volume mounting via CLI can be tricky, using YAML is recommended
# Create update file
cat > vaultwarden-update.yaml <<EOF
properties:
  template:
    containers:
    - name: vaultwarden
      image: vaultwarden/server:latest
      resources:
        cpu: 0.5
        memory: 1Gi
      volumeMounts:
      - volumeName: data
        mountPath: /data
      env:
      - name: ADMIN_TOKEN
        secretRef: admin-token
      - name: SIGNUPS_ALLOWED
        value: "true"
      - name: DOMAIN
        value: "https://$APP_URL"
    volumes:
    - name: data
      storageName: $STORAGE_MOUNT_NAME
      storageType: AzureFile
    scale:
      minReplicas: 1
      maxReplicas: 1
EOF

# Apply the update
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --yaml vaultwarden-update.yaml
```

**Completion Criteria:** Container restarts and data persists after restart

---

### Task 5.3: Add SMTP Configuration (Optional)

```bash
# Only run if you configured SMTP in Task 4.2
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --secrets \
    admin-token="$ADMIN_TOKEN" \
    smtp-password="$SMTP_PASSWORD" \
  --set-env-vars \
    SMTP_HOST="$SMTP_HOST" \
    SMTP_PORT="$SMTP_PORT" \
    SMTP_FROM="$SMTP_FROM" \
    SMTP_SECURITY="$SMTP_SECURITY" \
    SMTP_USERNAME="$SMTP_USERNAME" \
    SMTP_PASSWORD=secretref:smtp-password

echo "✅ SMTP configuration added"
```

**Completion Criteria:** Email notifications work (test with password hint)

---

## Phase 6: Initial Setup and Security Hardening

### Task 6.1: Create Your Account

1. **Navigate to:** `https://$APP_URL`
2. **Click:** "Create Account"
3. **Enter:** Your email and master password
   - Use a STRONG master password (20+ characters)
   - Store master password in a secure offline location
4. **Verify:** Can login to your account

**Completion Criteria:** Successfully logged into Vaultwarden web vault

---

### Task 6.2: Access Admin Panel

1. **Navigate to:** `https://$APP_URL/admin`
2. **Enter:** The admin token from Task 4.1
3. **Verify:** Can see admin dashboard

**Completion Criteria:** Admin panel accessible

---

### Task 6.3: Disable Public Signups

After creating your account (and any other accounts you need):

```bash
# Disable signups to prevent unauthorized accounts
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --set-env-vars \
    SIGNUPS_ALLOWED=false

echo "✅ Public signups disabled"
```

**Completion Criteria:** New signup attempts show "Registration not allowed"

---

### Task 6.4: Enable Additional Security Features

In the admin panel (`https://$APP_URL/admin`):

- [ ] **Disable password hints** (if not using SMTP)
- [ ] **Require email verification** (if using SMTP)
- [ ] **Configure invitation-only mode** (optional)
- [ ] **Review security settings**

**Completion Criteria:** Security settings configured to your preferences

---

## Phase 7: Backup and Disaster Recovery

### Task 7.1: Enable Azure Backup (Recommended)

```bash
# Create Recovery Services Vault
VAULT_NAME="rsv-vaultwarden"

az backup vault create \
  --name $VAULT_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION

echo "⚠️  Note: Azure Backup for File Shares requires additional configuration"
echo "Complete setup in Azure Portal: Backup Center → Configure Backup"
```

**Manual Steps in Portal:**
1. Go to Azure Portal → Backup Center
2. Click "+ Backup"
3. Select "Azure Files (Azure Storage)"
4. Select your storage account: `$STORAGE_ACCOUNT`
5. Select file share: `vaultwarden-data`
6. Choose backup policy (daily recommended)
7. Enable backup

**Completion Criteria:** Backup policy shows as active in Azure Portal

---

### Task 7.2: Test Backup and Restore

```bash
# Create a test file to verify backups work
az storage file upload \
  --account-name $STORAGE_ACCOUNT \
  --account-key $STORAGE_KEY \
  --share-name $FILE_SHARE \
  --source /dev/null \
  --path "backup-test.txt"

echo "✅ Test file created"
echo "Wait 24 hours for first backup, then test restore in Azure Portal"
```

**Completion Criteria:** After 24 hours, can see backup in Recovery Services Vault

---

### Task 7.3: Document Recovery Procedures

Create a recovery document:

```bash
cat > DISASTER_RECOVERY.md <<EOF
# Vaultwarden Disaster Recovery Plan

## Critical Information
- **Resource Group:** $RESOURCE_GROUP
- **Storage Account:** $STORAGE_ACCOUNT
- **File Share:** $FILE_SHARE
- **Container App:** $APP_NAME
- **Environment:** $ENVIRONMENT_NAME
- **Admin Token:** [Stored in password manager]

## Recovery Steps

### Scenario 1: Container App Deleted
```bash
# Redeploy using same storage (data persists)
az containerapp create \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --environment $ENVIRONMENT_NAME \
  --image vaultwarden/server:latest \
  [... rest of configuration ...]
```

### Scenario 2: Data Corruption
1. Go to Azure Portal → Storage Account → File Shares
2. Select $FILE_SHARE
3. Click "Restore" in backup section
4. Select recovery point
5. Restore to new share or overwrite

### Scenario 3: Complete Disaster
1. Restore storage from backup
2. Recreate Container App Environment
3. Redeploy Vaultwarden with restored storage

## Contact Information
- Azure Support: [Your support plan]
- Recovery Services Vault: $VAULT_NAME

EOF

echo "✅ Recovery documentation created: DISASTER_RECOVERY.md"
``` 

**Completion Criteria:** Recovery document saved in secure location

---

## Phase 8: Production Hardening (Optional but Recommended)

### Task 8.1: Configure Custom Domain

```bash
# Prerequisites: 
# - Own a domain name
# - Access to DNS settings

CUSTOM_DOMAIN="vault.yourdomain.com"

# Add custom domain to Container App
az containerapp hostname add \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --hostname $CUSTOM_DOMAIN

# Get the CNAME target
CNAME_TARGET=$(az containerapp show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "properties.configuration.ingress.fqdn" \
  --output tsv)

echo ""
echo "========================================="
echo "📋 DNS Configuration Required"
echo "========================================="
echo "Add this CNAME record to your DNS:"
echo ""
echo "Type: CNAME"
echo "Name: vault"
echo "Value: $CNAME_TARGET"
echo "TTL: 3600"
echo "========================================="
echo ""

read -p "Press Enter after adding DNS record..."

# Bind certificate (Container Apps provides free managed certificate)
az containerapp hostname bind \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --hostname $CUSTOM_DOMAIN \
  --environment $ENVIRONMENT_NAME \
  --validation-method CNAME

echo "✅ Custom domain configured"
```

**Completion Criteria:** Can access Vaultwarden at custom domain with valid HTTPS

---

### Task 8.2: Enable Diagnostic Logging

```bash
# Create Log Analytics Workspace
LOG_WORKSPACE="log-vaultwarden"

az monitor log-analytics workspace create \
  --resource-group $RESOURCE_GROUP \
  --workspace-name $LOG_WORKSPACE \
  --location $LOCATION

# Get workspace ID
WORKSPACE_ID=$(az monitor log-analytics workspace show \
  --resource-group $RESOURCE_GROUP \
  --workspace-name $LOG_WORKSPACE \
  --query "customerId" \
  --output tsv)

echo "✅ Log Analytics workspace created"
echo "Configure diagnostics in Azure Portal:"
echo "Container App → Diagnostic settings → Add diagnostic setting"
```

**Completion Criteria:** Logs visible in Log Analytics workspace

---

### Task 8.3: Set Up Monitoring and Alerts

```bash
# Create action group for alerts (email notification)
az monitor action-group create \
  --name "vaultwarden-alerts" \
  --resource-group $RESOURCE_GROUP \
  --short-name "VWAlerts" \
  --email-receiver \
    name="Admin" \
    email="your-email@example.com"

# Create alert for container restarts
CONTAINER_APP_ID=$(az containerapp show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "id" \
  --output tsv)

az monitor metrics alert create \
  --name "vaultwarden-restart-alert" \
  --resource-group $RESOURCE_GROUP \
  --scopes $CONTAINER_APP_ID \
  --condition "count Restarts > 3" \
  --window-size 5m \
  --evaluation-frequency 1m \
  --action "vaultwarden-alerts"

echo "✅ Monitoring alerts configured"
```

**Completion Criteria:** Test alert triggers email notification

---

### Task 8.4: Implement VNet Integration (Advanced)

For maximum security, isolate Vaultwarden in a Virtual Network:

```bash
# Create Virtual Network
VNET_NAME="vnet-vaultwarden"
SUBNET_NAME="subnet-containerapp"

az network vnet create \
  --name $VNET_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --address-prefix 10.0.0.0/16

az network vnet subnet create \
  --name $SUBNET_NAME \
  --resource-group $RESOURCE_GROUP \
  --vnet-name $VNET_NAME \
  --address-prefix 10.0.0.0/23

# Note: Recreating Container App Environment with VNet requires deletion
echo "⚠️  VNet integration requires recreating Container App Environment"
echo "This is an advanced configuration - document current setup first"
```

**Completion Criteria:** VNet created (implementation requires downtime)

---

## Phase 9: Testing and Validation

### Task 9.1: Test User Registration (Before Disabling)

- [ ] Create test account
- [ ] Login from web interface
- [ ] Install browser extension and login
- [ ] Install mobile app and login
- [ ] Sync works across devices

**Completion Criteria:** All clients can connect and sync

---

### Task 9.2: Test Password Operations

- [ ] Create new password entry
- [ ] Edit existing entry
- [ ] Delete entry
- [ ] Organize with folders
- [ ] Share item (if using org account)

**Completion Criteria:** All CRUD operations work

---

### Task 9.3: Test Data Persistence

```bash
# Restart container to verify data persists
az containerapp revision restart \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --revision $(az containerapp revision list \
    --name $APP_NAME \
    --resource-group $RESOURCE_GROUP \
    --query "[0].name" \
    --output tsv)

echo "✅ Container restarted - verify data still exists"
```

**Completion Criteria:** All passwords and settings intact after restart

---

### Task 9.4: Test Admin Panel Functions

In admin panel:
- [ ] View registered users
- [ ] Invite new user (if enabled)
- [ ] Delete user
- [ ] View diagnostics
- [ ] Check database integrity

**Completion Criteria:** Admin panel fully functional

---

### Task 9.5: Test Email Functionality (If Configured)

- [ ] Request password hint
- [ ] Test 2FA email codes
- [ ] Verify account email
- [ ] Test user invitation emails

**Completion Criteria:** All emails received successfully

---

## Phase 10: Documentation and Handoff

### Task 10.1: Create User Guide

```bash
cat > VAULTWARDEN_USER_GUIDE.md <<EOF
# Vaultwarden Access Guide

## Web Access
- **URL:** https://$APP_URL
- **Admin Panel:** https://$APP_URL/admin (admin only)

## Supported Clients
- Web Vault (any browser)
- Browser Extensions (Chrome, Firefox, Safari, Edge)
- Desktop Apps (Windows, macOS, Linux)
- Mobile Apps (iOS, Android)

## Configuration
All clients should use:
- **Server URL:** https://$APP_URL

## Getting Started
1. Download Bitwarden client for your platform
2. Choose "Self-hosted" option
3. Enter server URL: https://$APP_URL
4. Login with your credentials

## Support
- Admin contact: [your-email]
- Documentation: https://github.com/dani-garcia/vaultwarden/wiki

EOF

echo "✅ User guide created"
```

**Completion Criteria:** User guide saved and shared with team

---

### Task 10.2: Document Azure Resources

```bash
cat > AZURE_RESOURCES.md <<EOF
# Vaultwarden Azure Infrastructure

## Resource Group
- **Name:** $RESOURCE_GROUP
- **Location:** $LOCATION

## Container App
- **Name:** $APP_NAME
- **Environment:** $ENVIRONMENT_NAME
- **URL:** https://$APP_URL
- **Image:** vaultwarden/server:latest
- **Resources:** 0.5 CPU, 1Gi Memory
- **Replicas:** 1 (min and max)

## Storage
- **Account:** $STORAGE_ACCOUNT
- **File Share:** $FILE_SHARE
- **Quota:** 10GB
- **Redundancy:** Zone-Redundant (ZRS)
- **Soft Delete:** 7 days

## Backup
- **Vault:** $VAULT_NAME
- **Policy:** Daily backups
- **Retention:** [Configure in policy]

## Security
- **Admin Token:** Stored in [password manager]
- **HTTPS:** Enforced
- **Public Signups:** Disabled
- **TLS:** 1.2 minimum

## Monthly Costs (Estimated)
- Container Apps: ~$15-30/month
- Storage Account: ~$2-5/month
- Log Analytics: ~$2-10/month
- Backup: ~$1-3/month
- **Total:** ~$20-50/month

## Maintenance
- **Updates:** Manual (check vaultwarden releases)
- **Backups:** Automatic daily
- **Monitoring:** Azure Monitor alerts configured

EOF

echo "✅ Infrastructure documentation created"
```

**Completion Criteria:** All resources documented

---

### Task 10.3: Create Maintenance Checklist

```bash
cat > MAINTENANCE.md <<EOF
# Vaultwarden Maintenance Checklist

## Weekly Tasks
- [ ] Check backup status in Azure Portal
- [ ] Review Container App logs for errors
- [ ] Verify application is accessible

## Monthly Tasks
- [ ] Review Azure costs and optimize if needed
- [ ] Test backup restore procedure
- [ ] Check for Vaultwarden updates
- [ ] Review user accounts and remove inactive ones
- [ ] Update admin token (recommended every 90 days)

## Quarterly Tasks
- [ ] Full disaster recovery test
- [ ] Review and update security settings
- [ ] Audit access logs
- [ ] Review and update documentation

## Update Procedure
```bash
# Update to new version
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --image vaultwarden/server:VERSION

# Verify
# Test login and functionality
```

## Scaling (If Needed)
```bash
# Increase resources
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --cpu 1.0 \
  --memory 2.0Gi
```

EOF

echo "✅ Maintenance checklist created"
```

**Completion Criteria:** Maintenance schedule established

---

## Phase 11: Final Validation and Launch

### Task 11.1: Security Audit

- [ ] HTTPS enforced (no HTTP access)
- [ ] Admin token is strong (40+ characters)
- [ ] Public signups disabled
- [ ] Storage account has no public access
- [ ] Backups are enabled and tested
- [ ] Monitoring and alerts configured
- [ ] All secrets stored securely
- [ ] Recovery procedures documented

**Completion Criteria:** All security items checked

---

### Task 11.2: Performance Baseline

```bash
# Check current resource usage
az containerapp show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query "properties.template.containers[0].resources"

# Monitor for 24 hours then review metrics in Azure Portal
echo "Review metrics after 24 hours of use"
```

**Completion Criteria:** Baseline metrics documented

---

### Task 11.3: User Acceptance Testing

- [ ] 5+ passwords stored and retrieved
- [ ] Mobile app sync works
- [ ] Browser extension works
- [ ] Password generator works
- [ ] Secure notes work
- [ ] File attachments work (if enabled)
- [ ] 2FA works (if configured)

**Completion Criteria:** All features tested and working

---

### Task 11.4: Cost Review

```bash
# Check current month costs
az consumption usage list \
  --start-date $(date -u -d '1 month ago' '+%Y-%m-%dT%H:%M:%SZ') \
  --end-date $(date -u '+%Y-%m-%dT%H:%M:%SZ') \
  | grep -i vaultwarden

echo "Review costs in Azure Portal → Cost Management"
```

**Completion Criteria:** Monthly costs within budget

---

### Task 11.5: Create Runbook

```bash
cat > RUNBOOK.md <<EOF
# Vaultwarden Operations Runbook

## Common Issues and Solutions

### Issue: Cannot access Vaultwarden
**Symptoms:** Website not loading
**Troubleshooting:**
1. Check container status: `az containerapp show -n $APP_NAME -g $RESOURCE_GROUP`
2. Check logs: View in Azure Portal → Container App → Log stream
3. Verify DNS (if custom domain)
4. Check Azure service health

**Resolution:** Restart container if needed

### Issue: Login fails
**Symptoms:** Correct credentials rejected
**Troubleshooting:**
1. Verify master password
2. Check DOMAIN environment variable matches URL
3. Review logs for authentication errors

### Issue: Data lost after restart
**Symptoms:** Passwords missing after update
**Troubleshooting:**
1. Verify storage mount is attached
2. Check file share has data
3. Restore from backup if needed

### Issue: Slow performance
**Symptoms:** Page loads slowly
**Troubleshooting:**
1. Check CPU/Memory metrics
2. Increase container resources if needed
3. Consider upgrading SKU

## Emergency Contacts
- Azure Support: [your support plan]
- Admin: [your contact]

## Escalation Path
1. Check runbook
2. Review logs in Azure Portal
3. Check Azure service health
4. Open Azure support ticket
5. Restore from backup if critical

EOF

echo "✅ Runbook created"
```

**Completion Criteria:** Runbook tested with sample issue

---

## Completion Checklist

### Infrastructure
- [ ] Resource group created
- [ ] Storage account configured with security hardening
- [ ] File share created with soft delete
- [ ] Container App Environment deployed
- [ ] Storage mounted to environment

### Application
- [ ] Vaultwarden container deployed
- [ ] HTTPS enforced
- [ ] Admin token configured
- [ ] Initial account created
- [ ] Public signups disabled

### Security
- [ ] TLS 1.2 minimum enforced
- [ ] Public blob access disabled
- [ ] Admin token is strong and secured
- [ ] Backup enabled
- [ ] Monitoring configured

### Documentation
- [ ] User guide created
- [ ] Infrastructure documented
- [ ] Maintenance checklist created
- [ ] Disaster recovery plan documented
- [ ] Runbook created

### Testing
- [ ] Web access tested
- [ ] Mobile app tested
- [ ] Browser extension tested
- [ ] Data persistence verified
- [ ] Backup tested

---

## Post-Deployment

### Immediate Next Steps (First 24 Hours)
1. Import passwords from existing password manager
2. Install Bitwarden clients on all devices
3. Test sync across devices
4. Share credentials with DISASTER_RECOVERY.md location
5. Set calendar reminder for first backup check

### First Week
1. Monitor costs daily
2. Check logs for errors
3. Verify backups are running
4. Test password operations extensively
5. Configure 2FA on your account

### First Month
1. Review and optimize costs
2. Test backup restore procedure
3. Update documentation with any changes
4. Train other users (if applicable)
5. Schedule regular maintenance

---

## Troubleshooting Quick Reference

### View Logs
```bash
az containerapp logs show \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --follow
```

### Restart Container
```bash
az containerapp revision restart \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP
```

### Check Storage Files
```bash
az storage file list \
  --account-name $STORAGE_ACCOUNT \
  --account-key $STORAGE_KEY \
  --share-name $FILE_SHARE \
  --output table
```

### Update Environment Variable
```bash
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --set-env-vars KEY=VALUE
```

### Scale Resources
```bash
az containerapp update \
  --name $APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --cpu 1.0 \
  --memory 2.0Gi
```

---

## Additional Resources

- [Vaultwarden Wiki](https://github.com/dani-garcia/vaultwarden/wiki)
- [Azure Container Apps Documentation](https://learn.microsoft.com/en-us/azure/container-apps/)
- [Bitwarden Help Center](https://bitwarden.com/help/)
- [Azure Pricing Calculator](https://azure.microsoft.com/en-us/pricing/calculator/)

---

## Cost Optimization Tips

1. **Use Standard_LRS instead of Standard_ZRS** if you don't need zone redundancy (-30% storage cost)
2. **Reduce backup retention** to 7 days if longer not needed
3. **Use B-series VMs** for dev/test environments
4. **Monitor unused resources** with Azure Advisor
5. **Set up budget alerts** to avoid surprises

---

## Support and Community

- **GitHub Issues:** https://github.com/dani-garcia/vaultwarden/issues
- **Community Forum:** https://vaultwarden.discourse.group/
- **Azure Support:** https://azure.microsoft.com/en-us/support/

---

**Last Updated:** 2026-01-26 22:12:11
**Version:** 1.0
**Author:** jakehildreth
#!/bin/bash

# Get the name of the PostgreSQL pod dynamically
POSTGRES_POD=$(kubectl get pods -l app=postgres -o jsonpath='{.items[0].metadata.name}')

# Copy the pgdump file to your postgres pod
kubectl cp /home/ubuntu/dreamvacations_backup.sql "${POSTGRES_POD}":/dreamvacations_backup.sql

# Load the database to the app
kubectl exec -it "${POSTGRES_POD}" -- psql -U db_user_afz -d dreamvacations -f /dreamvacations_backup.sql

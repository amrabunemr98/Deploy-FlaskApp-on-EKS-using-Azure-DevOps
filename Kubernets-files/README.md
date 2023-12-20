# Flask-App And MySQL-DB Kubernetes Files
## Purpose
- This kubernetes files provides detailed for deploying Flask-App and MySQL-DB
## ConfigMap
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: flask-app-config
data:
  MYSQL_DATABASE_DB: BucketList
  MYSQL_DATABASE_USER: root
  MYSQL_DATABASE_HOST: mysql-service

```
### Description:
- The ConfigMap named flask-app-config contains configuration data for a Flask application.
- It defines MySQL database-related configuration values such as database name, user, and host.

## Deployment Flask-App
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flask-app-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      app: flask-app
  template:
    metadata:
      labels:
        app: flask-app
    spec:
      containers:
        - name: flask-app
          image: 817775426354.dkr.ecr.us-east-1.amazonaws.com/task-ecr-repo:build-${BUILD_NUMBER}-app
          ports:
            - containerPort: 5000
          readinessProbe:
            httpGet:
              path: /
              port: 5000
            initialDelaySeconds: 10
            periodSeconds: 5
          livenessProbe:
            httpGet:
              path: /
              port: 5000
            initialDelaySeconds: 30
            periodSeconds: 10
          resources:
            limits:
              cpu: "0.5"
              memory: "512Mi"
            requests:
              cpu: "0.1"
              memory: "128Mi"
          env:
            - name: MYSQL_DATABASE_USER
              valueFrom:
                configMapKeyRef:
                  name: flask-app-config
                  key: MYSQL_DATABASE_USER
            - name: MYSQL_DATABASE_DB
              valueFrom:
                configMapKeyRef:
                  name: flask-app-config
                  key: MYSQL_DATABASE_DB
            - name: MYSQL_DATABASE_HOST
              valueFrom:
                configMapKeyRef:
                  name: flask-app-config
                  key: MYSQL_DATABASE_HOST
            - name: MYSQL_DATABASE_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: MYSQL_DATABASE_PASSWORD
```
### Description:
- The Deployment named flask-app-deployment deploys a Flask application container.
- It uses environment variables from the ConfigMap for MySQL database configuration.
- Probes are defined for readiness and liveness checks.
- Resource limits for CPU and memory are set for the container.

## Ingress Controller
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: flask-app-ingress
  annotations:
    kubernetes.io/ingress.class: nginx
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  rules:
    - http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: flask-app-service
                port:
                  number: 80

```
### Description:
- The Ingress resource named flask-app-ingress defines routing rules for the Flask application.
- It uses the NGINX Ingress controller.
- Requests to the root path are directed to the flask-app-service on port 80.

## Secrets
```
apiVersion: v1
kind: Service
metadata:
  name: flask-app-service
spec:
  selector:
    app: flask-app
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000
```
### Description:
- The Secret named app-secrets contains sensitive information such as MySQL passwords.
- Values are base64-encoded for security.

## Services (Flask App):
```
apiVersion: v1
kind: Service
metadata:
  name: flask-app-service
spec:
  selector:
    app: flask-app
  type: LoadBalancer
  ports:
    - protocol: TCP
      port: 80
      targetPort: 5000

```
### Description:
- The Service named flask-app-service exposes the Flask application.
- It uses a LoadBalancer type for external access on port 80.

## Services (MySQL)
```
apiVersion: v1
kind: Service
metadata:
  name: mysql-service
spec:
  selector:
    app: mysql
  type: ClusterIP
  ports:
    - protocol: TCP
      port: 3306
      targetPort: 3306
```
### Description:
- The Service named mysql-service exposes the MySQL database service.
- It uses ClusterIP type for internal access on port 3306.

## PersistentVolume (MySQL)
```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: mysql-pv
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: mysql-storage
  hostPath:
    path: /var/lib/mysql
```
### Description:
- The PersistentVolume named mysql-pv provides persistent storage for the MySQL database.
- It has a capacity of 1Gi and uses a hostPath for storage.

## PersistentVolumeClaim (MySQL)
```
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mypvc
spec:
  resources:
    requests:
      storage: 1Gi
  accessModes:
    - ReadWriteOnce
  storageClassName: mysql-storage
```
### Description:
- The PersistentVolumeClaim named mypvc requests storage from the mysql-pv.
- It has a capacity of 1Gi and uses the mysql-storage storage class.

## Statefulset-DB
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: mysql-statefulset
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mysql
  serviceName: mysql-service
  template:
    metadata:
      labels:
        app: mysql
    spec:
      containers:
        - name: mysql
          image: 817775426354.dkr.ecr.us-east-1.amazonaws.com/task-ecr-repo:build-${BUILD_NUMBER}-db
          ports:
            - containerPort: 3306
          volumeMounts:
            - name: data-volume
              mountPath: /var/lib/mysql
          env:
            - name: MYSQL_ROOT_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: app-secrets
                  key: MYSQL_ROOT_PASSWORD
      volumes:
        - name: data-volume
          persistentVolumeClaim:
            claimName: mypvc
```
## Description:
- The StatefulSet named mysql-statefulset manages a stateful MySQL container.
- It ensures ordering and uniqueness for the pods.
- The MySQL container uses the previously defined persistent volume claim (mypvc).
- MySQL root password is sourced from the app-secrets secret.

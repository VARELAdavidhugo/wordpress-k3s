KUBECTL=kubectl
APP_DIR=k8s/app

.PHONY: deploy delete restart logs

deploy:
	@echo "🔧 Déploiement des manifests WordPress et MySQL..."
	$(KUBECTL) apply -f $(APP_DIR)/mysql-deploy.yaml
	$(KUBECTL) apply -f $(APP_DIR)/mysql-svc.yaml
	$(KUBECTL) apply -f $(APP_DIR)/wordpress-deploy.yaml
	$(KUBECTL) apply -f $(APP_DIR)/wordpress-svc.yaml

delete:
	@echo "🧹 Suppression des ressources WordPress et MySQL..."
	-$(KUBECTL) delete -f $(APP_DIR)/wordpress-svc.yaml
	-$(KUBECTL) delete -f $(APP_DIR)/wordpress-deploy.yaml
	-$(KUBECTL) delete -f $(APP_DIR)/mysql-svc.yaml
	-$(KUBECTL) delete -f $(APP_DIR)/mysql-deploy.yaml

restart: delete deploy

logs:
	@echo "📋 Logs du pod WordPress :"
	$(KUBECTL) logs -l app=wordpress

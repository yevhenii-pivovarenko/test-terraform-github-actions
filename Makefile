.PHONY: deploy-raw

deploy-raw:
	gcloud functions deploy python-http-function --gen2 --runtime=python312 --region=us-central1 --source=. --entry-point=hello --trigger-http --allow-unauthenticated
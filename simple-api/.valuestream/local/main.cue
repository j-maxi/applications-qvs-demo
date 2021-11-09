package local

_const: {
	#name: "simple-api"
	#port: 5000
}

DesignPattern: {
	name: "local"

	parameters: {
		namespace: string
		image:     string
	}

	resources: app: {
		namespace:  _namespace
		deployment: _deployment
		service:    _service
	}

	let _selector = {
		app: _const.#name
	}
	let _container = {
		name:  _const.#name
		image: parameters.image
		ports: [{
			containerPort: _const.#port
		}]
		resources: {
			requests: {
				cpu:    "100m"
				memory: "128Mi"
			}
			limits: {
				cpu:    "200m"
				memory: "256Mi"
			}
		}
	}
	_deployment: {
		apiVersion: "apps/v1"
		kind:       "Deployment"
		metadata: name: _const.#name
		spec: {
			replicas: 1
			selector: matchLabels: _selector
			template: {
				metadata: labels: _selector
				spec: containers: [
					_container,
				]
			}
		}
	}

	_service: {
		apiVersion: "v1"
		kind:       "Service"
		metadata: name: _const.#name
		spec: {
			type: "LoadBalancer"
			ports: [{
				port:       80
				targetPort: _const.#port
			}]
			selector: _selector
		}
	}

	_namespace: {
		apiVersion: "v1"
		kind:       "Namespace"
		metadata: name: parameters.namespace
	}

	// apply namespace
	_deployment: metadata: namespace: parameters.namespace
	_service: metadata: namespace:    parameters.namespace
}

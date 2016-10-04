[
    {
        "name": "${container_name}",
        "image": "${image_repository_url}",
        "cpu": 512,
        "memory": 1024,
        "essential": true,
        "portMappings": [
            {
                "containerPort": 8080
            }
        ]
    }
]

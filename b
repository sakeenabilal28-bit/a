<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>3D Light Bulb</title>
 
    <style>
        body {
            margin: 0;
            background: #111;
            color: white;
            font-family: Arial, sans-serif;
            text-align: center;
        }

        h1 {
            margin: 20px 0;
        }

        #scene-container {
            width: 100%;
            height: 400px;
        }

        .controls {
            margin-top: 20px;
        }

        button {
            padding: 10px 15px;
            margin: 5px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 5px;
        }

        #toggleBtn {
            background: orange;
        }

        .color {
            background: #444;
            color: white;
        }
    </style>

     
    <script src="https://cdn.jsdelivr.net/npm/three@0.152.2/build/three.min.js"></script>
</head>

<body>

    <h1>3D Light Bulb</h1>
 
    <div id="scene-container"></div>

   
    <div class="controls">
        <button id="toggleBtn">ON / OFF</button>
        <button class="color" data-color="yellow">Yellow</button>
        <button class="color" data-color="red">Red</button>
        <button class="color" data-color="blue">Blue</button>
        <button class="color" data-color="green">Green</button>
    </div>

    
    <script>
        const container = document.getElementById("scene-container");

        const scene = new THREE.Scene();

        const camera = new THREE.PerspectiveCamera(
            45,
            container.clientWidth / container.clientHeight,
            0.1,
            1000
        );
        camera.position.z = 5;

        const renderer = new THREE.WebGLRenderer({ antialias: true });
        renderer.setSize(container.clientWidth, container.clientHeight);
        container.appendChild(renderer.domElement);

        const bulbGeometry = new THREE.SphereGeometry(1, 32, 32);
        const bulbMaterial = new THREE.MeshStandardMaterial({
            color: 0xffffff,
            transparent: true,
            opacity: 0.6
        });
        const bulb = new THREE.Mesh(bulbGeometry, bulbMaterial);
        scene.add(bulb);

        const pointLight = new THREE.PointLight(0xffff00, 0, 10);
        pointLight.position.set(0, 0, 0);
        scene.add(pointLight);

        const ambientLight = new THREE.AmbientLight(0x404040);
        scene.add(ambientLight);

        let isOn = false;

        document.getElementById("toggleBtn").addEventListener("click", () => {
            isOn = !isOn;
            pointLight.intensity = isOn ? 2 : 0;
        });

        document.querySelectorAll(".color").forEach(button => {
            button.addEventListener("click", () => {
                const color = button.dataset.color;
                pointLight.color.set(color);
            });
        });

        function animate() {
            requestAnimationFrame(animate);
            bulb.rotation.y += 0.005;
            renderer.render(scene, camera);
        }

        animate();
    </script>

</body>
</html>

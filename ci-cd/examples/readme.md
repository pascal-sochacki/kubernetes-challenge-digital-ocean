Here are two files to verify tekton is working correctly.

Steps to run this example:
1) ``kubectl apply -f hello-world-task.yaml``
2) ``kubectl apply -f hello-world-taskrun.yaml``
3) ``tkn taskrun describe hello-run`` should show the result of the run

```
➜  examples git:(main) ✗ tkn taskrun describe hello-run
Name:              hello-run
Namespace:         default
Task Ref:          hello
Service Account:   default
Timeout:           1h0m0s
Labels:
 app.kubernetes.io/managed-by=tekton-pipelines
 tekton.dev/task=hello

🌡️  Status

STARTED         DURATION     STATUS
4 minutes ago   12 seconds   Succeeded

📨 Input Resources

 No input resources

📡 Output Resources

 No output resources

⚓ Params

 No params

📝 Results

 No results

📂 Workspaces

 No workspaces

🦶 Steps

 NAME      STATUS
 ∙ hello   Completed

🚗 Sidecars

No sidecars
```
4) `tkn taskrun logs hello-run` should show the output of the task
```
➜  examples git:(main) ✗ tkn taskrun logs hello-run
[hello] Hello World!

```

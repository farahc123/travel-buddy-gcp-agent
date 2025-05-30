# Travel buddy AI agent

- [Travel buddy AI agent](#travel-buddy-ai-agent)
  - [Goal of this project](#goal-of-this-project)
  - [Requirements](#requirements)
  - [Steps](#steps)

## Goal of this project

- https://codelabs.developers.google.com/devsite/codelabs/building-ai-agents-vertexai?hl=en#1 
- To create an AI agent using Vertex AI and GCP that helps users plan travel

## Requirements

- an `app.py` file containing the code for a basic Flask app
- an `index.html` file containing the code for the app's landing page
- a `Dockerfile` with instructions on how to build the image
- a GCP Artifact Repository (standard, type Docker) with the correct permissions to push the image to
- a file to be added as a data store, which provides additional knowledge base for the agent to consult (on top of the model's default knowledge base) — specifically, this data store instructs the agent on how to handle travel-related queries for Wakanda, a fictional location that the base model doesn't contain travel information for

## Steps

1. Create a conversational agent based on the *gemini-1.5-flash* model
2. Enable the API
3. Create the playbook for the agent, with the goal of helping customers answer travel-related queries
4. Add instructions to the playbook:
   1. Greet users and ask how you can help them
   2. Use ${TOOL: Alternative Location} if the user's request contains a location that does not exist
5. Add a datastore to the model to handle queries about Wakanda from the file *ai-workshops/agents/data/wakanda.txt*
6. Set the agent's grounding level to *Very low* to apply restrictions that will help prevent hallucinations
7. Publish the agent
8. Use the CSS code snippet from the step above to generate code for a simple Flask web app and save this code in a file called *app.py*
9.  Create a *requirements.txt* file with the web app's dependencies
10. Create a Dockerfile
11. Use a `gcloud` command to build and push a Docker image for this containerised app to a GCR repository
12.  Deploy the app to Cloud Run with a `gcloud run deploy` command

- Working app: ![working index.html](image.png)
- Testing the agent's ability to handle Wakanda-related travel questions ![Wakanda question](image-1.png)

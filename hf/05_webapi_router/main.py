from fastapi import FastAPI
from routers.items import router as items_router

app = FastAPI()
app.include_router(items_router)

#uvicorn main:app --reload
#get /items/
#get /itmes/item-code
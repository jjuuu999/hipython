from transformers import pipeline
from fastapi.middleware.cors import CORSMiddleware # 1. 미들웨어 임포트

# 2. CORS 설정: 브라우저의 접근을 허용합니다.
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"], # 모든 도메인 허용
    allow_methods=["*"],
    allow_headers=["*"],
)

# 모델 로드 (처음 실행 시 다운로드)
classifier = pipeline(
    "text-classification",
    model="snunlp/KR-FinBert-SC"
)

@app.post("/sentiment")
def analyze_sentiment(data: SentimentRequest):
    results = classifier(data.text)
    return {"text": data.text, "label": results[0]["label"], "score": results[0]["score"]}
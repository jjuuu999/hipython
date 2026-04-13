import os
from dotenv import load_dotenv
from langchain_community.document_loaders import PyPDFLoader
from langchain_text_splitters import RecursiveCharacterTextSplitter # 텍스트 분할기 추가
from langchain_openai import OpenAIEmbeddings, ChatOpenAI
from langchain_community.vectorstores import FAISS
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.runnables import RunnablePassthrough
from langchain_core.output_parsers import StrOutputParser

load_dotenv()

def load_rag_chain(pdf_path: str, model: str = "gpt-4o-mini"):
    
    # DB를 저장할 폴더 경로 설정 (pdf 파일이 있는 폴더 안에 'SdriveDB'를 만듭니다)
    db_dir = os.path.join(os.path.dirname(pdf_path), "SdriveDB")
    embeddings = OpenAIEmbeddings()

    # --- [핵심 로직] 저장된 DB가 있는지 검사 ---
    if os.path.exists(db_dir):
        # 1. 이미 DB가 있다면: PDF 로딩 다 건너뛰고 1초 만에 DB만 쏙 불러옵니다.
        # (주의: 로컬 DB를 불러올 때는 allow_dangerous_deserialization=True 옵션이 필요합니다)
        vectordb = FAISS.load_local(db_dir, embeddings, allow_dangerous_deserialization=True)
        
    else:
        # 2. DB가 없다면: 처음 실행하는 것이므로 PDF를 읽고 DB를 새로 만듭니다.
        # #1. PDF 로딩
        loader = PyPDFLoader(pdf_path)
        docs = loader.load()

        # #2. 텍스트 분할
        text_splitter = RecursiveCharacterTextSplitter(chunk_size=1000, chunk_overlap=100)
        splits = text_splitter.split_documents(docs)

        # #3. 임베딩 + 벡터 DB 생성 및 영구 저장
        vectordb = FAISS.from_documents(splits, embeddings)
        vectordb.save_local(db_dir) # 👈 이 한 줄로 하드디스크에 영구 저장됩니다!

    # 검색기(Retriever) 설정
    retriever = vectordb.as_retriever(search_kwargs={"k": 3})

    # 4. 프롬프트
    prompt = ChatPromptTemplate.from_template("""
    너는 삼성전자 메모리카드 매뉴얼 전문 어시스턴트이다.
    다음의 참고 문서를 바탕으로 질문에 정확하게 답하라.

    [참고문서]
    {context}

    [질문]
    {question}

    한글로 간결하고 정확하게 답변하라.
    """)

    # 5. RAG 체인
    llm = ChatOpenAI(model=model, temperature=0)
    rag_chain = (
        {"context": retriever, "question": RunnablePassthrough()}
        | prompt
        | llm
        | StrOutputParser()
    )

    return rag_chain
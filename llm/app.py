import streamlit as st
import os
# rag_chain.py에서 새롭게 만든 load_rag_chain 함수를 불러옵니다.
from rag_chain import load_rag_chain

# -----------------------------------------------
# 페이지 설정
# -----------------------------------------------
st.set_page_config(
    page_title="삼성 메모리카드 매뉴얼 챗봇",
    page_icon="📖",
    layout="centered"
)

st.title("삼성 메모리카드 매뉴얼 챗봇")
st.caption("매뉴얼 기반으로 정확한 답변을 제공합니다.")

# -----------------------------------------------
# RAG 체인 초기화 (최초 1회만 실행)
# -----------------------------------------------
@st.cache_resource
def load_chain():
    # 현재 파일 위치를 기준으로 안전하게 파일 경로 생성
    base_dir = os.path.dirname(os.path.abspath(__file__))
    
    # ⚠️ 파일명이 본인 데이터 폴더에 있는 것과 똑같은지 마지막으로 확인해 주세요!
    file_path = os.path.join(base_dir, "data", "Samsung_Card_Manual_Korean_1.3.pdf") 
    
    return load_rag_chain(pdf_path=file_path)

rag_chain = load_chain()

# -----------------------------------------------
# 대화 히스토리 초기화
# -----------------------------------------------
if "messages" not in st.session_state:
    st.session_state.messages = []

# -----------------------------------------------
# 이전 대화 출력
# -----------------------------------------------
for msg in st.session_state.messages:
    with st.chat_message(msg["role"]):
        st.markdown(msg["content"])

# -----------------------------------------------
# 사용자 입력 처리
# -----------------------------------------------
if prompt := st.chat_input("메모리카드 매뉴얼에 대해 궁금한 점을 물어보세요!"):
    
    # 1. 사용자 질문 화면 출력 및 저장
    with st.chat_message("user"):
        st.markdown(prompt)
    st.session_state.messages.append({"role": "user", "content": prompt})

    # 2. 챗봇 답변 생성, 출력 및 저장
    with st.chat_message("assistant"):
        with st.spinner("매뉴얼을 검색하여 답변을 작성 중입니다..."):
            # RAG 체인 실행
            response = rag_chain.invoke(prompt)
            st.markdown(response)
            
    st.session_state.messages.append({"role": "assistant", "content": response})
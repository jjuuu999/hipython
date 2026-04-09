import yfinance as yf
import pandas as pd

class Stock:
    def __init__(self, symbol: str):
        self.ticker = yf.Ticker(symbol)

    def get_basic_info(self) -> str:
        # info 딕셔너리를 데이터프레임으로 변환
        info_dict = self.ticker.info
        df = pd.DataFrame.from_dict(info_dict, orient='index', columns=['Value'])
        
        # 🚨 에러 방지: 요구하는 항목이 해당 주식 정보에 없을 경우를 대비해 존재하는 것만 필터링
        target_items = ['longName', 'industry', 'sector', 'marketCap', 'sharesOutstanding']
        valid_items = [item for item in target_items if item in df.index]
        
        df = df.loc[valid_items]
        df = df.rename_axis('항목')
        return df.to_markdown()

    def get_financial_statement(self) -> str:
        # 1. 원본 데이터프레임 불러오기
        inc_df = self.ticker.quarterly_income_stmt
        bal_df = self.ticker.quarterly_balance_sheet
        cfs_df = self.ticker.quarterly_cash_flow

        # 2. 리스크 분석을 위한 핵심 항목 리스트
        inc_items = ['Total Revenue', 'Operating Income', 'Net Income', 'EBIT', 'Interest Expense']
        bal_items = ['Total Assets', 'Total Liabilities Net Minority Interest', 'Stockholders Equity', 
                    'Total Debt', 'Current Assets', 'Current Liabilities', 'Cash And Cash Equivalents']
        cfs_items = ['Operating Cash Flow', 'Investing Cash Flow', 'Financing Cash Flow', 
                    'Capital Expenditure', 'Free Cash Flow']

        # 🚨 3. 누락되었던 핵심 로직: 에러 방지용 헬퍼 함수 및 데이터 추출
        def extract_safe(df, items):
            if df is None or df.empty:
                return pd.DataFrame() # 데이터가 없으면 빈 데이터프레임 반환
            
            # 데이터프레임의 인덱스에 실제로 존재하는 항목만 안전하게 교집합으로 가져옴
            valid_items = [item for item in items if item in df.index]
            return df.loc[valid_items].rename_axis('항목').rename(columns=lambda x: x.strftime("%Y-%m-%d"))

        # 4. 변수에 추출된 데이터 할당 (이 부분이 있어야 return에서 에러가 안 납니다!)
        inc = extract_safe(inc_df, inc_items)
        bal = extract_safe(bal_df, bal_items)
        cfs = extract_safe(cfs_df, cfs_items)

        # 5. 마크다운 형태로 병합하여 반환
        return (
            "### Quarterly Income Statement\n" + inc.to_markdown() + "\n\n" +
            "### Quarterly Balance Sheet\n"  + bal.to_markdown() + "\n\n" +
            "### Quarterly Cash Flow\n"      + cfs.to_markdown()
        )
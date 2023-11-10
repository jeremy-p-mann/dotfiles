import io
from typing import Dict, List

import openai
import pandas as pd
import pynvim  # type: ignore
from pynvim.api import Nvim  # type: ignore
from sqlalchemy import create_engine


def parse_script(buffer: List[str]):
    ans = {}
    found_url = False
    found_dialect = False
    ans['sql'] = ''
    found_url = False
    for i, line in enumerate(buffer):
        if found_url:
            ans['sql'] += f'{line}\n'
        elif 'url: ' in line:
            ans['url'] = line.split(' ')[-1]
            found_url = True
    return ans


def get_data_lines(script: Dict) -> List[str]:
    url = script['url']
    engine = create_engine(url)
    try:
        df = pd.read_sql(script['sql'], engine).astype(str)
        for col in df.columns:
            max_len = int(df[col].str.len().max())
            df[col] = df[col].apply(lambda x: (x + (max_len-len(x)) * ' '))
        str_io = io.StringIO()
        df.to_csv(str_io, index=False, sep= '|')
        return str_io.getvalue().split('\n')
    except Exception as e:
        return str(e).split('\n')


@pynvim.plugin
class SQL(object):
    def __init__(self, nvim: Nvim):
        self.nvim = nvim

    @pynvim.command('ExecuteSQL', nargs='*', range='')
    def execute_sql(self, args, range):
        buffer = self.nvim.current.buffer
        script = parse_script(buffer)
        lines = get_data_lines(script)

        buffer = self.nvim.api.create_buf(False, True)

        # Calculate size of window
        width = max(len(line) for line in lines) + 3
        height = len(lines)

        # Calculate position of window
        win_height = self.nvim.api.get_option('lines')
        win_width = self.nvim.api.get_option('columns')
        row = int(win_height)
        col = int((win_width - width) / 2)

        # Define config for the floating window
        config = {
            'relative': 'editor',
            'anchor': 'SW',
            'width': win_width,
            'height': height,
            'row': win_height,
            'col': 0,
        }

        # Create floating window
        window = self.nvim.api.open_win(buffer, True, config)

        # Set lines in buffer
        self.nvim.api.buf_set_lines(buffer, 0, -1, True, lines)

from typing import Dict, List

import pynvim  # type: ignore
from openai import OpenAI
from pynvim.api import Nvim  # type: ignore

client = OpenAI()


def parse_chat(buffer: List[str]):
    speaker_lines = [
        (i, line[3:].lower()) for i, line in enumerate(buffer) if '## ' == line[:3]
    ]
    ans = [
        {'role': term[1], 'content': '\n'.join(
            buffer[(term[0]+1):speaker_lines[i+1][0]])}
        if i < len(speaker_lines) - 1
        else
        {'role': term[1], 'content': '\n'.join(buffer[(term[0]+1):])}
        for i, term in enumerate(speaker_lines)
    ]
    return ans


def get_response_from_model(chat: List[Dict[str, str]]):
    first_term = chat[0]
    if first_term['role'] == 'model':
        model = first_term['content'].replace('\n', '').replace(' ', '')
        chat = chat[1:]
    else:
        model = "gpt-3.5-turbo"
    chat_completion = client.chat.completions.create(
        model=model, messages=chat
    )
    ans = dict(chat_completion.choices[0].message)
    return ans


def format_response(resp):
    role, content = resp['role'], resp['content']
    header = [f'## {role[0].upper()}{role[1:]}', '']
    content = content.split('\n')
    return [header, *content]

# BUFFER = '''
# ## Model

# gpt-3.5-turbo

# ## System

# You are a good person

# ## User

# How are you

# ## Assistant

# I am good

# ## User

# Where are you from?

# '''.split('\n')

# ans = parse_chat(BUFFER)
# assert ans['messages'] == [
#     {'role': 'system', 'content': '\n'.join(BUFFER[2:5])},
#     {'role': 'user', 'content': '\n'.join(BUFFER[6:9])},
#     {'role': 'assistant', 'content': '\n'.join(BUFFER[10:13])},
#     {'role': 'user', 'content': '\n'.join(BUFFER[14:])},
# ]
# assert ans['model'] == 'gpt-3.5-turbo'

# resp = get_response_from_model(ans)
# import pdb; pdb.set_trace()


@pynvim.plugin
class Limit(object):
    def __init__(self, nvim: Nvim):
        self.nvim = nvim

    @pynvim.command('Chat', nargs='*', range='')
    def chat(self, args, range):
        buffer = self.nvim.current.buffer
        ans = parse_chat(buffer)
        buffer.append('## Loading')
        resp = get_response_from_model(ans)
        f_resp = format_response(resp)
        del buffer[-1]
        for line in f_resp:
            buffer.append(line)

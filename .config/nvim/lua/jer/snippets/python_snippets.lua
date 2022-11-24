local ls = require "luasnip"
local ps = ls.parser.parse_snippet

local snippets = {
  ps(
    "pytest_test",
    [[
def test_$1($2):
    $3
]]
  ),
  ps(
    "shebang",
    [[
#!/usr/bin/env python3
]]
  ),
ps(
  "pytest_fixture",
  [[
@pytest.fixture($1)
def $2($3):
    $4
]]
),
ps(
  "parameterized_fixture",
  [[
@pytest.fixture(params=$1)
def $2(request, $3):
    $4
]]
),
  ps(
    "for_loop_snippet",
    [[
for ${1:item} in ${2:iterable_object}:
    ${3:do_something}
]]
  ),
ps(
  "function_snippet",
  [[
def $1($2) -> $3:
    $4
]]
),
ps(
  "data_class",
  [[
@dataclass
class $1:
    $2: $3
    $4
]]
),
ps(
  "property",
  [[

@property
def $1(self) -> ${2:Any}:
    $3
    return ${4:None}
]]
),
ps(
  "method",
  [[

def $1(self, $2${3: Any}) -> ${3:Any}:
    $3
    return ${4:None}
]]
),
ps(
  "abstract_method",
  [[
@abstract_method
def $1(self, $2${3: Any}) -> ${3:Any}:
    $3
    return ${4:None}
]]
),
ps(
  "setuppy",
  [[
from setuptools import setup, find_packages

setup(
    name='$1',
    packages=find_packages(),
    install_requires=[$3],
)
]]
),
ps(
  "if_name_equals_name",
  [[
if __name__ == '__main__':
    ${1:main()}
]]
),
ps(
  "load_yaml",
  [[
with open("$1", 'r') as f:
    try:
        $2 = yaml.safe_load(f)
    except yaml.YAMLError as exc:
        print(exc)
]]
),
ps(
  "load_json",
  [[
with open("$1.json", 'r') as file:
    $2 = json.load(file)
]]
),
ps(
  "listdir",
  [[
os.listdir('${1:filepath}')
]]
),
ps(
  "matplotlib_figure",
  [[
fig = plt.figure(figsize=(10, 10))
ax = plt.axes()
$1
ax.set(
    xlim=${2:None},
    ylim=${3:None},
    xlabel='$4',
    ylabel='$5',
    title='$6'
)

fig.savefig('${1:figure_name}.png')
]]
),
ps(
  "bp",
  [[
breakpoint()
]]
),
ps(
  "correlation_plot",
  [[
fig = plt.figure(figsize=(12, 12))
corr = np.round(${1:DATAFRAME}.corr(), decimals=2)
mask = np.triu(np.ones_like(corr, dtype=np.bool), k=1)
sns.heatmap(corr,
    mask=mask,
    cmap='RdBu',
    vmin=-1,
    vmax=1,
    linewidths=3,
    square=True,
    cbar=False,
    annot=True
    )
plt.tick_params(labelrotation=45)
plt.title(
    '(Pearson) Correlations of ${2:DESCRIPTION}',
    fontdict={'fontsize': 30})
]]
),
ps(
  "np_rng",
  [[
rng = np.random.default_rng(seed=$1)$2
]]
),
ps(
  "slice_reverse_function",
  [[
def slice_reverse(word: str) -> str:
    ans = word[::-1]
    return ans
]]
),
ps(
  "for_loop_reverse_function",
  [[
def for_loop_reverse(word: str) -> str:
    n_letters = len(word)
    ans = ''
    for index in range(n_letters):
        reverse_index = n_letters - (index + 1)
        ans += word[reverse_index]
    return ans
]]
),
ps(
  "bert reverse",
  [[
def bert(word: str) -> str:
    qa_model = pipeline(
        task='question-answering',
        model='distilbert-base-cased-distilled-squad'
    )
    question = f"What is the reverse of the string '{word}'?"
    # context = f'the answer is {slice_reverse(word)}'
    context = "the reverse of the string 'foo' is 'oof'. the reverse of the string 'glad' is 'dalg'"
    ans = qa_model(question=question, context=context)['answer']
    return ans
]]
),
ps(
  "load_words",
  [[
def get_words() -> List[str]:
    with open("./tests/mocks/words.yml", 'r') as f:
        return yaml.safe_load(f)
]]
),
}

return snippets

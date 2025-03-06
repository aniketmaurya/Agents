# AI Doot 🤖 - Your Agentic Workflow Wizard 🧙‍♂️

Ready to turn your ideas into action? Build intelligent agent workflows that actually **think** with function calling. ✨

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/aniketmaurya/python-project-template?template=false)

<a target="_blank" href="https://lightning.ai/lightning-ai/studios/introduction-to-ai-agents">
  <img src="https://pl-bolts-doc-images.s3.us-east-2.amazonaws.com/app-2/studio-badge.svg" alt="Open In Studio"/>
</a>

## 🛠️ Installation - Get in the Game

Get the latest version like a pro:

```bash
pip install git+https://github.com/aniketmaurya/aidoot.git@main
```

Or, for the **mad scientists** who like things editable:

```bash
git clone https://github.com/aniketmaurya/aidoot.git
cd aidoot
pip install -e .
```

## 💡 Supported LLMs - Your AI Friends

- ✅ **OpenAI** (Because, duh, it’s OpenAI)
- ✅ **Cohere Command R and Command R+** (For when you need some extra punch)
- ✅ **LlamaCPP** (Open-source and proud, baby)

## 🚀 Usage / Examples - Put It to Work

### 🧰 Tooling Up with Local or Cloud LLMs

Here’s a quick showstopper using an LLM with weather data:

```python
from aidoot.llms import LlamaCppChatCompletion
from aidoot.tools import get_current_weather, wikipedia_search
from aidoot.tool_executor import need_tool_use

llm = LlamaCppChatCompletion.from_default_llm(n_ctx=0)
llm.bind_tools([get_current_weather, wikipedia_search])  # Add tools from LangChain

messages = [
    {"role": "user", "content": "how is the weather in London today?"}
]

output = llm.chat_completion(messages)

if need_tool_use(output):
    print("Using weather tool... it's about to get real")
    tool_results = llm.run_tools(output)
    tool_results[0]["role"] = "assistant"

    updated_messages = messages + tool_results
    updated_messages.append({"role": "user", "content": "Think step by step and answer my question based on the above context."})
    output = llm.chat_completion(updated_messages)

print(output.choices[0].message.content)
```

<details>
    <summary>Expand output... (Go ahead, don't be shy)</summary>

```text
Alright, let's break this down for you like a pro:

1. **Temperature**: 23°C (73°F) - Gorgeous! 👌
2. **Cloud Cover**: Zero clouds. The sun is out. 🌞
3. **Humidity**: 38%. Not too sticky. 
4. **Precipitation**: Nada. Dry as a desert. 🌵
5. **Pressure**: 1023 hPa. Weather’s stable, people. 📏
6. **Visibility**: 10 km. No fog, no drama. 👀
7. **Weather Condition**: It’s sunny, it’s lovely, it’s perfect. 🌅
8. **Wind**: A breezy 9 km/h. Just enough to mess up your hair. 💨

So yeah, it's a fantastic day to be out and about in London. 🌍
```

</details>

### ✨ Multi-modal Agent - See the World Through AI Eyes 👁🤖️

What if your AI could *see*? Well, it can. Let’s make it happen with computer vision!

Example: AI analyzing an image and giving you location recommendations in London (because why not?):

```python
from agents.llms import LlamaCppChatCompletion
from agents.tools import wikipedia_search, google_search, image_inspector

llm = LlamaCppChatCompletion.from_default_llm(n_ctx=0)
llm.bind_tools([google_search, wikipedia_search, image_inspector])

image_url = "https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Gfp-wisconsin-madison-the-nature-boardwalk.jpg/2560px-Gfp-wisconsin-madison-the-nature-boardwalk.jpg"
messages = [
    {"role": "system", "content": "You're an ultra-intelligent assistant who knows all the things. Use your powers!"}, 
    {"role": "user", "content": f"Check this image {image_url} and tell me where in London I can go that looks like this."}
]

output = llm.chat_completion(messages)
tool_results = llm.run_tools(output)

updated_messages = messages + tool_results
messages = updated_messages + [{"role": "user", "content": "Answer based on the tool results. Go on, impress me."}]
output = llm.chat_completion(messages)

print(output.choices[0].message.content)
```

<details>
    <summary>Expand output... (Let’s see what the AI has to say)</summary>

```text
Okay, okay, let's break this down! The image you uploaded shows a serene nature boardwalk, surrounded by lush greenery and a peaceful, cloudy sky. Looks like the perfect place for a casual walk or a zen moment. 🌿

In London, here’s where you can find your zen:

1. **Richmond Park**: The big daddy of London parks. Wide open spaces, lakes, and a majestic atmosphere. 🌳
2. **Hampstead Heath**: For the wanderer, with ponds, meadows, and wooded areas to explore. 🌲
3. **Greenwich Park**: With its stunning views and historic landmarks. You’ll feel like royalty. 👑
4. **Victoria Park**: A chill vibe with lakes and gardens. Perfect for a day out. 🌸
5. **Hyde Park**: The classic. The heart of London’s park life. 🏞️

These parks? Totally on-brand with that image you shared. Your perfect outdoor day awaits. 🌞
```

</details>

## 🙌 Acknowledgements

Built with love, powered by PyCharm 🧡 (Thanks, JetBrains, for the free credits — you're awesome).

<img src="https://resources.jetbrains.com/storage/products/company/brand/logos/PyCharm_icon.svg" alt="PyCharm logo">
<img src="https://resources.jetbrains.com/storage/products/company/brand/logos/jetbrains.svg" alt="JetBrains logo">
```

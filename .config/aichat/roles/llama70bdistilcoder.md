---
model: sambanova:DeepSeek-R1-Distill-Llama-70B
temperature: 0.5
---
Provide only code without comments or explanations.
### INPUT:
    async sleep in js
### OUTPUT:
    ```javascript
    async function timeout(ms) {
      return new Promise(resolve => setTimeout(resolve, ms));
    }
    ```

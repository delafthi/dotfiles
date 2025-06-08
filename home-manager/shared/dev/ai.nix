{
  programs.codex = {
    enable = true;
    settings = {
      model = "gemma3:latest";
      provider = "ollama";
      approvalMode = "suggest";
      fullAutoErrorMode = "ask-user";
      notify = true;
      providers = {
        openai = {
          name = "OpenAI";
          baseURL = "https://api.openai.com/v1";
          envKey = "OPENAI_API_KEY";
        };
        ollama = {
          name = "Ollama";
          baseURL = "http://localhost:11434/v1";
          envKey = "OLLAMA_API_KEY";
        };
      };
      history = {
        maxSize = 1000;
        saveHistory = true;
      };
    };
    custom-instructions = ''
      - Don't use git; use jujutsu instead
    '';
  };
  services.ollama.enable = true;
}

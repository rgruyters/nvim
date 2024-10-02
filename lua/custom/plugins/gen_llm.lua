return {
  'David-Kunz/gen.nvim',
  event = 'InsertEnter',
  opts = {
    model = 'deepseek-coder',
  },
  config = function(_, opts)
    local gen = require('gen')
    gen.setup(opts)
    gen.prompts['Work_With_Me'] = {
      prompt = 'You are a senior devops engineer, acting as an assistant. You offer help with cloud technologies like: Terraform, AWS, Kubernetes, Python and Go. You answer with code examples when possible. $input:\n$text',
      replace = true,
    }
  end,
}

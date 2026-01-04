local rg = import 'lib/rg.libsonnet';
local patterns = import 'custom_types.json';

local type_patterns = {
  "style": "*.{css,sass,less,stylus}",
  "pug": "*.{pug,jade}",
  "tmpl": "*.{html,hbs,pug}",
  "dts": "*.d.ts",
  "spec": "*.{spec,test}.{ts,tsx,js,jsx}",
  "test": "*.{spec,test}.{ts,tsx,js,jsx}",
  "tsx": "*.tsx",
  "stories": "**/*.stories.{ts,tsx,js,jsx,mdx}",
  "jsx": "*.jsx",
  "gql": "*.{graphql,gql}",
  "pkg": "{package,deno}.json",
  "md": "*.{md,mdx}"
};

local Misc() = 
  [
    rg.Comment("Misc", true),
    rg.MaxColumns(80),
    rg.MaxColumnsPreview(),
    rg.SmartCase(),
    rg.Follow(),
    rg.Hidden(),
    rg.GitGlob(),
  ];

local Types() =
  [
    rg.Comment("File Types", true),
    std.mapWithIndex(
      function(index, name)
        rg.TypeAdd(name, type_patterns[name], index > 0),
    std.objectFields(type_patterns)),
  ];

{
  "config":
    rg.Config(
      Misc() +
      Types(),
      false, true),
}

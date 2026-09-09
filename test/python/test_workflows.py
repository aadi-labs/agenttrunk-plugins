import importlib.util
import inspect
import json
import unittest
from pathlib import Path
from agenttrunk import AgentTrunk

ROOT = Path(__file__).resolve().parents[2]
class WorkflowTests(unittest.TestCase):
    def test_all_cookbook_calls_match_generated_python_signatures(self):
        client = AgentTrunk(access_token='local-test')
        for recipe in json.loads((ROOT/'examples/workflows/recipes.json').read_text()):
            with self.subTest(recipe=recipe['name']):
                folder=ROOT/'examples/workflows'/recipe['name']
                spec=importlib.util.spec_from_file_location('recipe',folder/'main.py')
                module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
                group,method=recipe['operation'].split('.')
                def snake(s):
                    import re
                    return re.sub(r'[A-Z]',lambda m:'_'+m[0].lower(),s)
                signature=inspect.signature(getattr(getattr(client,snake(group)),snake(method)))
                class Capture:
                    def __getattr__(self,_): return self
                    def __call__(self,*args,**kwargs): signature.bind(*args,**kwargs)
                module.execute(Capture(),json.loads((folder/'request.json').read_text()))

    def test_publication_recipe_sends_complete_package_to_explicit_scope(self):
        import httpx
        folder=ROOT/'examples/workflows/publish-package'
        spec=importlib.util.spec_from_file_location('publish_recipe',folder/'main.py')
        module=importlib.util.module_from_spec(spec);spec.loader.exec_module(module)
        payload=json.loads((folder/'request.json').read_text())
        payload['trunkId']='w';payload['request']['scopeId']='s';payload['request']['contextKey']='k'
        calls=[]
        def handler(request):
            calls.append(request)
            body=json.loads(request.content)
            self.assertEqual(body['scopeId'],'s')
            self.assertEqual([f['path'] for f in body['files']],['SKILL.md','references/escalation.md'])
            self.assertTrue(all(f['contentBase64'] for f in body['files']))
            return httpx.Response(200,json=json.loads((ROOT/'test/ruby/manifest.json').read_text()))
        with httpx.Client(transport=httpx.MockTransport(handler)) as http:
            result=module.execute(AgentTrunk(access_token='test',httpx_client=http),payload)
            self.assertEqual(result.revision.id,'a'*64)
        self.assertEqual(len(calls),1)

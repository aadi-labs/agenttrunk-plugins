"""Native Hermes registration; no credential discovery or network side effects."""
from pathlib import Path


def register(ctx):
    ctx.register_skill("agenttrunk", Path(__file__).parent / "skills" / "agenttrunk" / "SKILL.md")

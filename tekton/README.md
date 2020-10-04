# Tekton

## Version

```bash
tkn version
# Client version: 0.11.0
# Pipeline version: v0.16.3
# Triggers version: v0.8.1
```

## API resources

```txt
NAME                      SHORTNAMES    APIGROUP                NAMESPACED    KIND
extensions                ext,exts      dashboard.tekton.dev    true          Extension
clustertasks                            tekton.dev              false         ClusterTask
conditions                              tekton.dev              true          Condition
pipelineresources                       tekton.dev              true          PipelineResource
pipelineruns              pr,prs        tekton.dev              true          PipelineRun
pipelines                               tekton.dev              true          Pipeline
runs                                    tekton.dev              true          Run
taskruns                  tr,trs        tekton.dev              true          TaskRun
tasks                                   tekton.dev              true          Task
clustertriggerbindings    ctb           triggers.tekton.dev     false         ClusterTriggerBinding
eventlisteners            el            triggers.tekton.dev     true          EventListener
triggerbindings           tb            triggers.tekton.dev     true          TriggerBinding
triggers                  tri           triggers.tekton.dev     true          Trigger
triggertemplates          tt            triggers.tekton.dev     true          TriggerTemplate
```

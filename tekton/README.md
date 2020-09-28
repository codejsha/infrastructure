# Tekton

## API resources

```txt
NAME                      SHORTNAMES    APIGROUP                NAMESPACED    KIND
extensions                ext,exts      dashboard.tekton.dev    true          Extension
clustertasks                            tekton.dev              false         ClusterTask
conditions                              tekton.dev              true          Condition
pipelineresources                       tekton.dev              true          PipelineResource
pipelineruns              pr,prs        tekton.dev              true          PipelineRun
pipelines                               tekton.dev              true          Pipeline
taskruns                  tr,trs        tekton.dev              true          TaskRun
tasks                                   tekton.dev              true          Task
clustertriggerbindings    ctb           triggers.tekton.dev     false         ClusterTriggerBinding
eventlisteners            el            triggers.tekton.dev     true          EventListener
triggerbindings           tb            triggers.tekton.dev     true          TriggerBinding
triggertemplates          tt            triggers.tekton.dev     true          TriggerTemplate
```

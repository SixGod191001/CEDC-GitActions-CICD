import boto3
import os
import datetime

def lambda_handler(event, context):

    # region=os.environ['AWS_REGION']
    state_machine_name = event['detail']['state_machine_name']
    # sfn_client = boto3.client('stepfunctions',region_name=region)
    sfn_client = boto3.client('stepfunctions')
    state_machines = sfn_client.list_state_machines(maxResults=1000)
    sta_mach = [st for st in state_machines.get("stateMachines") if st["name"] == state_machine_name]
    state_machine_arn = sta_mach[0]["stateMachine"]
    load_id = datetime.datetime.utcnow().strftime("%Y%m%d%H%M%S")
    response = sfn_client.start_execution(
        stateMachineArn=state_machine_arn,
        name=f"{load_id}-{state_machine_name}"
    )
    return {
        "成功启动{step_functions_name}:".format(state_machine_name)
    }

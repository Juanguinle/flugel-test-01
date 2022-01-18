package main

import (
	"log"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestTerraformS3AndEC2Tags(t *testing.T) {
	
	options := &terraform.Options{
		TerraformDir: "../examples/plan",
	}

	defer terraform.Destroy(t, options)

	init, err := terraform.InitE(t, options) 
	if err != nil {	log.Println(err) }	
	t.Log(init)

	plan, err := terraform.PlanE(t, options) 
	if err != nil {	log.Println(err) }
	t.Log(plan)
	
	apply, err := terraform.ApplyE(t, options) 
	if err != nil {	log.Println(err) }
	t.Log(apply)		
	

	region := "us-west-2"
	expectedTagKey1 := "Name"
	expectedTagValue1 := "Flugel"
	expectedTagKey2 := "Owner"
	expectedTagValue2 := "InfraTeam"


	bucketID := terraform.Output(t, options, "bucket_id")
	actualBucketTags := aws.GetS3BucketTags(t, region, bucketID)

	instanceID := terraform.Output(t, options, "instance_id")
	actualInstanceTags := aws.GetTagsForEc2Instance(t, region, instanceID)

	
	assert.Equal(t, expectedTagValue1, actualBucketTags[expectedTagKey1]  )
	assert.Equal(t, expectedTagValue1, actualInstanceTags[expectedTagKey1])
	assert.Equal(t, expectedTagValue2, actualBucketTags[expectedTagKey2]  )
	assert.Equal(t, expectedTagValue2, actualInstanceTags[expectedTagKey2])

}
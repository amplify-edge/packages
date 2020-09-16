package services_test

import (
	"io/ioutil"
	"testing"

	"github.com/getcouragenow/core-runtime/tool/lang/services"
)

var (
	arbData = []byte(`
{
  "@@last_modified": "2020-05-08T01:32:44.656753",
  "country": "Country Road Take Me Home To The Place I Belong West Virginia Country Mama Take Me Home Country Road",
  "@country": {
    "description": "Country",
    "type": "text",
    "placeholders": {}
  },
  "newCountrySelected": "New Country Selected",
  "@newCountrySelected": {
    "description": "New Country Selected",
    "type": "text",
    "placeholders": {}
  },
  "zipCode": "Zip Code",
  "@zipCode": {
    "description": "Zip Code",
    "type": "text",
    "placeholders": {}
  },
  "whereAreYou": "Where are you?",
  "@whereAreYou": {
    "description": "Where are you?",
    "type": "text",
    "placeholders": {}
  },
  "category": "Category",
  "@category": {
    "description": "Category",
    "type": "text",
    "placeholders": {}
  },
  "campaignName": "Campaign Name",
  "@campaignName": {
    "description": "campaignName",
    "type": "text",
    "placeholders": {}
  },
  "noCampaigns": "No Campaigns",
  "@noCampaigns": {
    "description": "No Campaigns",
    "type": "text",
    "placeholders": {}
  },
  "actionType": "Type of Action",
  "@actionType": {
    "description": "Type of Action",
    "type": "text",
    "placeholders": {}
  },
  "actionLocation": "Action Location",
  "@actionLocation": {
    "description": "Action Location",
    "type": "text",
    "placeholders": {}
  },
  "time": "Time",
  "@time": {
    "description": "Time",
    "type": "text",
    "placeholders": {}
  },
  "lengthOfTheAction": "Length of the Action",
  "@lengthOfTheAction": {
    "description": "Length of the Action",
    "type": "text",
    "placeholders": {}
  },
  "goal": "Goal",
  "@goal": {
    "description": "Goal",
    "type": "text",
    "placeholders": {}
  },
  "strategy": "Strategy",
  "@strategy": {
    "description": "strategy",
    "type": "text",
    "placeholders": {}
  },
  "historicalPrecedents": "Historical Precedents",
  "@historicalPrecedents": {
    "description": "Historical Precedents",
    "type": "text",
    "placeholders": {}
  },
  "backingEndorsingOrganizations": "Backing/Endorsing Organizations",
  "@backingEndorsingOrganizations": {
    "description": "Backing/Endorsing Organizations",
    "type": "text",
    "placeholders": {}
  },
  "peopleAlreadyPledged": "People already pledged",
  "@peopleAlreadyPledged": {
    "description": "People already pledged",
    "type": "text",
    "placeholders": {}
  },
  "weNeed": "We Need",
  "@weNeed": {
    "description": "We Need",
    "type": "text",
    "placeholders": {}
  },
  "extrapolatedSimilarPastActions": "The following figures are extrapolated from similar past actions that both succeeded and failed",
  "@extrapolatedSimilarPastActions": {
    "description": "The following figures are extrapolated from similar past actions that both succeeded and failed",
    "type": "text",
    "placeholders": {}
  },
  "pioneersToStart": "Pioneers needed to start",
  "@pioneersToStart": {
    "description": "Pioneers needed to start",
    "type": "text",
    "placeholders": {}
  },
  "rebelsMedia": "Rebels needed to trigger media",
  "@rebelsMedia": {
    "description": "Rebels needed to trigger media",
    "type": "text",
    "placeholders": {}
  },
  "rebelsWin": "Rebels needed to win",
  "@rebelsWin": {
    "description": "Rebels needed to win",
    "type": "text",
    "placeholders": {}
  },
  "contactDetails": "Contact Details",
  "@contactDetails": {
    "description": "Contact Details",
    "type": "text",
    "placeholders": {}
  },
  "notReady": "Not Ready",
  "@notReady": {
    "description": "Not Ready",
    "type": "text",
    "placeholders": {}
  },
  "ready": "Ready",
  "@ready": {
    "description": "Ready",
    "type": "text",
    "placeholders": {}
  },
  "selectCampaign": "Select Campaign",
  "@selectCampaign": {
    "description": "Select Campaign",
    "type": "text",
    "placeholders": {}
  },
  "campaignDetails": "Campaign Details",
  "@campaignDetails": {
    "description": "campaignDetails",
    "type": "text",
    "placeholders": {}
  },
  "searchCampaigns": "Search Campaigns",
  "@searchCampaigns": {
    "description": "Search Campaigns",
    "type": "text",
    "placeholders": {}
  },
  "yourNeeds": "Your Needs",
  "@yourNeeds": {
    "description": "Your Needs",
    "type": "text",
    "placeholders": {}
  },
  "needsSatisifiedRequirement": "Please choose as many supports or needs you need satisfied to join the action.",
  "@needsSatisifiedRequirement": {
    "description": "Please choose as many supports or needs you need satisfied to join the action.",
    "type": "text",
    "placeholders": {}
  },
  "next": "Next",
  "@next": {
    "description": "Next",
    "type": "text",
    "placeholders": {}
  },
  "supportRole": "Support Role",
  "@supportRole": {
    "description": "Support Role",
    "type": "text",
    "placeholders": {}
  },
  "provideSupportRole": "If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike?",
  "@provideSupportRole": {
    "description": "If we cannot satisfy your chosen conditions, would you consider providing a support role to those willing to go on strike?",
    "type": "text",
    "placeholders": {}
  },
  "yes": "Yes",
  "@yes": {
    "description": "Yes",
    "type": "text",
    "placeholders": {}
  },
  "no": "No",
  "@no": {
    "description": "No",
    "type": "text",
    "placeholders": {}
  },
  "supportRoles": "Support Roles",
  "@supportRoles": {
    "description": "Support Roles",
    "type": "text",
    "placeholders": {}
  }
}
`)
)

const (
	success = "\u2713"
	failed  = "\u274c"
)

func TestTranslate(t *testing.T) {
	if err := ioutil.WriteFile("/tmp/data.arb", arbData, 0644); err != nil {
		t.Fatalf("\t%s\tShould be able to write data file to /tmp: %v", failed, err)
	}
	t.Run("Test Multi Languages Files From Template", testGenerateMultiLanguageFilesFromTemplate)
}

func testGenerateMultiLanguageFilesFromTemplate(t *testing.T) {
	t.Log("Test multi language files from template")
	{
		err := services.GenerateMultiLanguageFilesFromTemplate(
			"/tmp/data.arb",
			"/tmp",
			"out",
			".json",
			[]string{"fr", "es", "de", "it", "ur"},
			false,
		)
		if err != nil {
			t.Fatalf(
				"\t%s\tShould be able to write translated output files to /tmp, got: %v",
				failed,
				err,
			)
		}
		t.Logf("\t%s\tShould be able to write translated output files to /tmp",
			success)
	}
}

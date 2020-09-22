package services

import (
	"github.com/emirpasic/gods/maps/linkedhashmap"
	"testing"
	"time"
)

var (
	arbData = []byte(`
{
  "@@last_modified": "2020-05-08T01:32:44.656753",
  "country": "Country Road Take Me Home To The Place I Belong West Virginia Country Mama Take me home country road",
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
	success   = "\u2713"
	failed    = "\u274c"
	separator = "=="
)

var translated []Translate
var m = linkedhashmap.New()

func TestTemplate(t *testing.T) {
	t.Run("Test getTemplateWords", testGetTemplateWords)
	t.Run("Test getTranslatedMaps", testGetTranslatedMaps)
}

func testGetTemplateWords(t *testing.T) {
	t.Log("Test getting translations from template")
	{
		err := m.FromJSON(arbData)
		if err != nil {
			t.Fatalf("\t%s\tShould be able to get linkedhashmap from json data: %v",
				failed, err)
		}

		translated, err = getTemplateWords(
			m, 3*time.Second, 3, "en", []string{"en", "fr", "de", "it", "ur"},
		)
		if err != nil {
			t.Fatalf(
				"\t%s\tShould be able to get translated words from google, got: %v",
				failed, err,
			)
		}
		t.Logf("\t%s\tShould be able to get translated words from google: %v",
			success, translated)

		if m.Size() != 71 {
			t.Fatalf("\t%s\tMap size should've been the same as the number of arb keys: %v",
				failed, m.Size())
		}
		

		for _, w := range translated {
			t.Logf("Per lang: %v", w.Words)
			if len(w.Words) != 35 {
				t.Fatalf("\t%s\tShould return the same amount of word as translated => expected: %d, got: %d",
					failed, 35, len(w.Words))
			}
		}
	}
}

func testGetTranslatedMaps(t *testing.T) {
	t.Log("Tests mapping translated words back to map")
	{
		_, err := getTranslatedMaps(translated, m, true)
		if err != nil {
			t.Fatalf("\t%s\tShould be able to map translated words back to the linkedhashmap: %v",
				failed, err)
		}
		t.Logf("\t%s\tShould be able to map translated words back to the linkedhashmap",
			success)
	}
}

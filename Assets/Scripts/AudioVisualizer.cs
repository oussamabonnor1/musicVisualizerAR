using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AudioVisualizer : MonoBehaviour {

	public AudioSource music;
	public float[] samples = new float[512];
	public GameObject[] cubes;

	// Use this for initialization
	void Start () {
		music = GetComponent<AudioSource>();
	}
	
	// Update is called once per frame
	void Update () {
		getSamples();
	}

	void getSamples(){
		music.GetSpectrumData(samples, 0, FFTWindow.Blackman);
		for (int i = 0; i < cubes.Length; i++)
		{
			cubes[i].transform.localScale  = new Vector3(.3f, .3f,-.1f + ((float) (samples[i] * -1.2)));
		}
	}
}
